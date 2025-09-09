local wasProximityDisabledFromOverride = false
disableProximityCycle = false

RegisterCommand("setvoiceintent",function(source,args)
	local intent = args[1]
	if intent == "speech" then
		MumbleSetAudioInputIntent(`speech`)
	elseif intent == "music" then
		MumbleSetAudioInputIntent(`music`)
	end
	LocalPlayer.state:set("voiceIntent",intent,true)
end)

RegisterCommand("volume",function(_,Message)
	local Volume = parseInt(Message[1],true)
	if not Volume or Volume < 0 or Volume > 100 then
		TriggerEvent("Notify","Configurações","Use um valor entre 0 e 100.","vermelho",5000)
		return false
	end

	setVolume(Volume)
	TriggerEvent("Notify","Configurações","<b>Volume:</b> "..Volume.."%","verde",5000)
end)

exports("setAllowProximityCycleState",function(state)
	type_check({ state,"boolean" })
	disableProximityCycle = state
end)

function setProximityState(proximityRange,isCustom)
	local voiceModeData = Cfg.voiceModes[mode]
	MumbleSetTalkerProximity(proximityRange + 0.0)
	LocalPlayer.state:set("proximity",{
		index = mode,
		distance = proximityRange,
		mode = isCustom and "Custom" or voiceModeData[2]
	},true)

	sendUIMessage({ voiceMode = isCustom and #Cfg.voiceModes or mode - 1 })
end

exports("overrideProximityRange",function(range,disableCycle)
	type_check({ range,"number" })
	setProximityState(range,true)
	if disableCycle then
		disableProximityCycle = true
		wasProximityDisabledFromOverride = true
	end
end)

exports("clearProximityOverride",function()
	local voiceModeData = Cfg.voiceModes[mode]
	setProximityState(voiceModeData[1],false)
	if wasProximityDisabledFromOverride then
		disableProximityCycle = false
	end
end)

local LastMode = 2
RegisterCommand("cycleproximity",function()
	if disableProximityCycle then return end

	local newMode = mode + 1

	if newMode <= 4 then
		mode = newMode
	else
		mode = 1
	end

	setProximityState(Cfg.voiceModes[mode][1],false)
	TriggerEvent("pma-voice:setTalkingMode",mode)
	TriggerEvent("hud:Voip",mode)
	LastMode = mode
end,false)

RegisterKeyMapping("cycleproximity","Distância de voz.","keyboard","HOME")
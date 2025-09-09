-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("trucker",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Payments = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {
	{ ["Item"] = "plastic", ["Chance"] = 75, ["Min"] = 225, ["Max"] = 275, ["Addition"] = 0.050 },
	{ ["Item"] = "glass", ["Chance"] = 75, ["Min"] = 225, ["Max"] = 275, ["Addition"] = 0.050 },
	{ ["Item"] = "rubber", ["Chance"] = 75, ["Min"] = 225, ["Max"] = 275, ["Addition"] = 0.050 },
	{ ["Item"] = "aluminum", ["Chance"] = 25, ["Min"] = 175, ["Max"] = 200, ["Addition"] = 0.025 },
	{ ["Item"] = "copper", ["Chance"] = 25, ["Min"] = 175, ["Max"] = 200, ["Addition"] = 0.025 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Payment()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Coords = vRP.GetEntityCoords(source)
		if not vRPC.LastVehicle(source,"packer") or #(Coords - vec3(1256.59,-3239.63,5.17)) > 25 then
			exports["discord"]:Embed("Hackers","**[PASSAPORTE]:** "..Passport.."\n**[FUNÇÃO]:** Payment do Trucker",source)

			Payments[Passport] = (Payments[Passport] or 0) + 1
			if Payments[Passport] >= 3 then
				vRP.SetBanned(Passport,-1,"Permanente","Hacker")
			end
		end

		local GainExperience = 15
		local Result = RandPercentage(Drops)
		local Experience,Level = vRP.GetExperience(Passport,"Trucker")
		local Valuation = Result["Valuation"] + Result["Valuation"] * (Result["Addition"] * Level)

		if exports["inventory"]:Buffs("Dexterity",Passport) then
			Valuation = Valuation + (Valuation * 0.1)
		end

		for Permission,Multiplier in pairs({ Ouro = 0.1, Prata = 0.075, Bronze = 0.05 }) do
			if vRP.HasService(Passport,Permission) then
				Valuation = Valuation + (Valuation * Multiplier)
				GainExperience = GainExperience + 5
			end
		end

		if not vRP.MaxItens(Passport,Result["Item"],Valuation) and vRP.CheckWeight(Passport,Result["Item"],Valuation) then
			vRP.GenerateItem(Passport,Result["Item"],Valuation,true)
		else
			TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
			exports["inventory"]:Drops(Passport,source,Result["Item"],Valuation)
		end

		vRP.PutExperience(Passport,"Trucker",GainExperience)
		vRP.BattlepassPoints(Passport,GainExperience)
		vRP.UpgradeStress(Passport,10)

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end

	if Payments[Passport] then
		Payments[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Lasted = {}
local Camera = nil
local Default = nil
local Locations = {}
local Barbershop = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Save",function(Data,Callback)
	if LocalPlayer["state"]["Creation"] then
		DoScreenFadeOut(0)
		SetTimeout(2500,function()
			TriggerEvent("hud:Active",true)
			DoScreenFadeIn(2500)
		end)
	else
		TriggerEvent("hud:Active",true)
	end

	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	vSERVER.Update(Barbershop,LocalPlayer["state"]["Creation"])
	LocalPlayer["state"]:set("Creation",false,false)
	LocalPlayer["state"]:set("Hoverfy",true,false)
	SetNuiFocus(false,false)
	vRP.Destroy()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Reset",function(Data,Callback)
	if LocalPlayer["state"]["Creation"] then
		DoScreenFadeOut(0)
		SetTimeout(2500,function()
			TriggerEvent("hud:Active",true)
			DoScreenFadeIn(2500)
		end)
	else
		TriggerEvent("hud:Active",true)
	end

	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	vSERVER.Update(Lasted,LocalPlayer["state"]["Creation"])
	LocalPlayer["state"]:set("Creation",false,false)
	LocalPlayer["state"]:set("Hoverfy",true,false)
	exports["barbershop"]:Apply(Lasted)
	SetNuiFocus(false,false)
	vRP.Destroy()
	Lasted = {}

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	exports["barbershop"]:Apply(Data)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Apply")
AddEventHandler("barbershop:Apply",function(Data)
	exports["barbershop"]:Apply(Data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Apply",function(Data,Ped)
	Ped = Ped or PlayerPedId()

	if Data then
		Barbershop = Data
	end

	for Number = 1,49 do
		if not Barbershop[Number] then
			Barbershop[Number] = (Number >= 6 and Number <= 9) and -1 or 0
		end
	end

	vRPS.Barbershop(Barbershop)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Open")
AddEventHandler("barbershop:Open",function()
	OpenBarbershop(true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenBarbershop(Mode)
	for Number = 1,49 do
		if not Barbershop[Number] then
			Barbershop[Number] = (Number >= 6 and Number <= 9) and -1 or 0
		end
	end

	vRP.playAnim(true,{"mp_sleep","bind_pose_180"},true)
	LocalPlayer["state"]:set("Hoverfy",false,false)
	TriggerEvent("hud:Active",false)
	Lasted = Barbershop

	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)
	local Coords = GetOffsetFromEntityInWorldCoords(Ped,-0.05,0.7,0.5)

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"])
	RenderScriptCams(true,false,0,false,false)
	SetCamRot(Camera,0.0,0.0,Heading + 200)
	SetEntityHeading(Ped,Heading)
	SetCamActive(Camera,true)
	Default = Coords["z"]

	if LocalPlayer["state"]["Creation"] then
		SetTimeout(2500,function()
			SendNUIMessage({ Action = "Open", Payload = { Barbershop,GetNumberOfPedDrawableVariations(Ped,2) - 1,Mode,LocalPlayer["state"]["Creation"] } })
			SetNuiFocus(true,true)
			DoScreenFadeIn(2500)
		end)
	else
		SendNUIMessage({ Action = "Open", Payload = { Barbershop,GetNumberOfPedDrawableVariations(Ped,2) - 1,Mode,LocalPlayer["state"]["Creation"] } })
		SetNuiFocus(true,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Init")
AddEventHandler("barbershop:Init",function(Data)
	Locations = Data

	local Table = {}
	for _,v in pairs(Locations) do
		table.insert(Table,{ vec3(v.Coords.x,v.Coords.y,v.Coords.z),2.5,"E","Pressione","para abrir" })
	end

	TriggerEvent("hoverfy:Insert",Table)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP:INSERT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Insert")
AddEventHandler("barbershop:Insert",function(Data)
	table.insert(Locations,Data)

	TriggerEvent("hoverfy:Insert",{
		{ vec3(Data.Coords.x,Data.Coords.y,Data.Coords.z),2.5,"E","Pressione","para abrir" }
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			for _,v in pairs(Locations) do
				if #(Coords - vec3(v.Coords.x,v.Coords.y,v.Coords.z)) <= 2.5 then
					TimeDistance = 1

					if IsControlJustPressed(1,38) and not exports["hud"]:Wanted() and (not v.Permission or LocalPlayer["state"][v.Permission]) then
						OpenBarbershop(vSERVER.Mode())
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATION
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Creation",function(Heading)
	local Ped = PlayerPedId()
	if not IsEntityVisible(Ped) then
		SetEntityVisible(Ped,true)
	end

	LocalPlayer["state"]:set("Creation",true,false)
	OpenBarbershop(true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate",function(Data,Callback)
	local Ped = PlayerPedId()
	local Direction = Data.direction
	local Heading = GetEntityHeading(Ped)
	local Coords = GetCamCoord(Camera)
	local CurrentZ = Coords.z

	if Direction == "Left" then
		SetEntityHeading(Ped,Heading - 5)
	elseif Direction == "Right" then
		SetEntityHeading(Ped,Heading + 5)
	elseif Direction == "Top" and (CurrentZ + 0.05) <= (Default + 0.50) then
		SetCamCoord(Camera,Coords.x,Coords.y,CurrentZ + 0.05)
	elseif Direction == "Bottom" and (CurrentZ - 0.05) >= (Default - 0.50) then
		SetCamCoord(Camera,Coords.x,Coords.y,CurrentZ - 0.05)
	end

	Callback("Ok")
end)
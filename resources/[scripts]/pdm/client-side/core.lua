-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("pdm")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Lasted = ""
local Camera = nil
local Selected = 1
local Mounted = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
local Config = {
	{
		Coords = vec3(-56.86,-1097.95,26.33),
		Cam = vec4(-49.14,-1099.56,26.92,294.81),
		Spawn = vec4(-44.42,-1097.44,26.23,28.35),
		DriveIn = vec4(-54.56,-1075.18,26.45,68.04),
		DriveOut = vec4(-58.04,-1096.02,25.42,209.77)
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Index,v in pairs(Config) do
		exports["target"]:AddCircleZone("PDM:"..Index,v.Coords,0.1,{
			name = "PDM:"..Index,
			heading = 0.0,
			useZ = true
		},{
			shop = Index,
			Distance = 1.25,
			options = {
				{ event = "pdm:Open", label = "Abrir", tunnel = "client" }
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAMERAACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function CameraActive()
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	RenderScriptCams(true,false,0,false,false)
	SetCamActive(Camera,true)

	SetCamRot(Camera,0.0,0.0,Config[Selected].Cam.w)
	SetCamCoord(Camera,Config[Selected].Cam.xyz)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PDM:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("pdm:Open",function(Number)
	Selected = Number

	if DoesEntityExist(Mounted) then
		DeleteEntity(Mounted)
		Mounted = nil
	end

	if not LocalPlayer.state.Buttons and not LocalPlayer.state.Commands and not exports["hud"]:Wanted() then
		CameraActive()
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		TriggerEvent("hud:Active",false)
		SendNUIMessage({ Action = "Open", Payload = { VehicleList(),vSERVER.Discount() } })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SystemClose()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Mount",function(Data,Callback)
	local Model = Data.vehicle
	if LoadModel(Model) and Lasted ~= Model then
		if DoesEntityExist(Mounted) then
			DeleteEntity(Mounted)
			Mounted = nil
		end

		Mounted = CreateVehicle(Model,Config[Selected].Spawn,false,false)
		SetVehicleCustomSecondaryColour(Mounted,88,101,242)
		SetVehicleCustomPrimaryColour(Mounted,88,101,242)
		SetVehicleNumberPlateText(Mounted,"PDMSPORT")
		SetEntityCollision(Mounted,false,false)
		FreezeEntityPosition(Mounted,true)
		SetEntityInvincible(Mounted,true)
		SetVehicleDirtLevel(Mounted,0.0)
		Lasted = Model
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Buy",function(Data,Callback)
	local Sucess = vSERVER.Buy(Data.vehicle)

	if Sucess then
		SendNUIMessage({ Action = "Close" })
		SystemClose()
	end

	Callback(Sucess)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate",function(Data,Callback)
	if not DoesEntityExist(Mounted) then
		return Callback("Ok")
	end

	local Heading = GetEntityHeading(Mounted)
	local Offset = Data.direction == "Left" and -5 or 5

	SetEntityHeading(Mounted,Heading + Offset)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Drive", function(Data, Callback)
	if not vSERVER.Check() or not LoadModel(Data.vehicle) then
		return Callback("Ok")
	end

	SendNUIMessage({ Action = "Close" })
	SystemClose()

	if DoesEntityExist(Mounted) then
		DeleteEntity(Mounted)
	end

	Mounted = CreateVehicle(Data.vehicle,Config[Selected].DriveIn,false,false)

	SetVehicleModKit(Mounted,0)
	SetVehicleDirtLevel(Mounted,0.0)
	ToggleVehicleMod(Mounted,18,true)
	SetEntityInvincible(Mounted,true)
	SetPedIntoVehicle(PlayerPedId(),Mounted,-1)
	SetVehicleNumberPlateText(Mounted,"PDMSPORT")
	SetVehicleCustomPrimaryColour(Mounted,88,101,242)
	SetVehicleCustomSecondaryColour(Mounted,88,101,242)

	for _,Type in ipairs({ 11, 12, 13, 15 }) do
		SetVehicleMod(Mounted,Type,GetNumVehicleMods(Mounted,Type) - 1,false)
	end

	LocalPlayer["state"]:set("Commands",true,true)
	LocalPlayer["state"]:set("TestDrive",true,false)

	CreateThread(function()
		while true do
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				vSERVER.Remove()
				LocalPlayer["state"]:set("Commands",false,true)
				LocalPlayer["state"]:set("TestDrive",false,false)

				SetEntityHeading(Ped,Config[Selected].DriveOut.w)
				SetEntityCoords(Ped,Config[Selected].DriveOut.xyz)

				if DoesEntityExist(Mounted) then
					DeleteEntity(Mounted)
					break
				end
			end

			Wait(1)
		end
	end)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEMCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function SystemClose()
	if DoesEntityExist(Mounted) then
		DeleteEntity(Mounted)
		Mounted = nil
	end

	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	Lasted = ""
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	TriggerEvent("hud:Active",true)
end
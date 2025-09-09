-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("bus")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Selected = 1
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUS:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("bus:Init",function()
	Active = not Active

	if not Active then
		RemoveBlip(Blip)
		Blip = nil
	end

	exports["target"]:LabelText("WorkBus",Active and "Finalizar Expediente" or "Iniciar Expediente")

	TriggerEvent("Notify","Central de Empregos",Active and "Você acaba de dar início à sua jornada de trabalho, lembrando que a sua vida não se resume só a isso." or "Você acaba de finalizar sua jornada de trabalho, esperamos que você tenha aprendido bastante hoje.","default",5000)

	if Active then
		MakeBlips()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	exports["target"]:AddBoxZone("WorkBus",Init["xyz"],0.75,0.75,{
		name = "WorkBus",
		heading = Init["w"],
		minZ = Init["z"] - 1.0,
		maxZ = Init["z"] + 1.0
	},{
		Distance = 1.75,
		options = {
			{
				event = "bus:Init",
				label = "Iniciar Expediente",
				tunnel = "client"
			}
		}
	})

	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if Active then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			if Vehicle ~= 0 and GetEntityArchetypeName(Vehicle) == "bus" then
				local Coords = GetEntityCoords(Ped)
				local Destination = Locations[Selected]
				local Distance = #(Coords - Destination)

				if Distance <= 200 then
					TimeDistance = 1

					DrawMarker(22,Destination.x,Destination.y,Destination.z + 3.0,0.0,0.0,0.0,0.0,180.0,0.0,7.5,7.5,5.0,88,101,242,175,0,0,0,1)
					DrawMarker(1,Destination.x,Destination.y,Destination.z - 3.0,0.0,0.0,0.0,0.0,0.0,0.0,15.0,15.0,10.0,255,255,255,50,0,0,0,0)

					if Distance <= 10 then
						vSERVER.Payment(Selected)
						Selected = (Selected % #Locations) + 1
						MakeBlips()
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function MakeBlips()
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	Blip = AddBlipForCoord(Locations[Selected]["x"],Locations[Selected]["y"],Locations[Selected]["z"])
	SetBlipSprite(Blip,1)
	SetBlipDisplay(Blip,4)
	SetBlipAsShortRange(Blip,true)
	SetBlipColour(Blip,77)
	SetBlipScale(Blip,0.75)
	SetBlipRoute(Blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Motorista")
	EndTextCommandSetBlipName(Blip)
end
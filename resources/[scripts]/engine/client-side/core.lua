-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("engine")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Price = 0
local Lasted = 0
local Display = false
local VehicleFuel = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(Event,Message)
	if Event == "CEventNetworkPlayerEnteredVehicle" and Message[1] == PlayerId() then
		local Ped = PlayerPedId()
		local Vehicle = Message[2]
		if not Entity(Vehicle).state.Fuel then
			Entity(Vehicle).state:set("Fuel",100.0,true)
		end

		SetPedConfigFlag(Ped,35,false)
		SetVehicleFuelLevel(Vehicle,Entity(Vehicle).state.Fuel + 0.0)

		if not IsPedInAnyHeli(Ped) then
			TriggerEvent("inventory:CleanWeapons")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:FUELADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:FuelAdmin")
AddEventHandler("engine:FuelAdmin",function()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		Entity(Vehicle).state:set("Fuel",100.0,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
local Consume = {
	[1.0] = 0.675,
	[0.9] = 0.625,
	[0.8] = 0.575,
	[0.7] = 0.525,
	[0.6] = 0.475,
	[0.5] = 0.425,
	[0.4] = 0.375,
	[0.3] = 0.325,
	[0.2] = 0.275,
	[0.1] = 0.125,
	[0.0] = 0.025
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Tables = {
	["RopeHandles"] = {},
	["Attributes"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OFFSETS
-----------------------------------------------------------------------------------------------------------------------------------------
local Offsets = {
	[-2007231801] = 2.3,
	[1339433404] = 2.3,
	[1694452750] = 2.3,
	[1933174915] = 2.3,
	[-462817101] = 1.8,
	[-469694731] = 2.5,
	[-164877493] = 1.6
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FLOOR
-----------------------------------------------------------------------------------------------------------------------------------------
function floor(Number)
	return math.floor(Number * 10 + 0.5) * 0.1
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			local Class = GetVehicleClass(Vehicle)
			if Class ~= 13 and Class ~= 14 then
				local CurrentFuel = GetVehicleFuelLevel(Vehicle)
				if CurrentFuel >= 1 then
					if (GetEntitySpeed(Vehicle) * 3.6) >= 1 then
						local RPM = floor(GetVehicleCurrentRpm(Vehicle))
						local Consumption = (Consume[RPM] or 1.0) * 0.1
						local NewFuel = CurrentFuel - Consumption

						SetVehicleFuelLevel(Vehicle,NewFuel)

						if GetPedInVehicleSeat(Vehicle,-1) == Ped then
							Entity(Vehicle).state:set("Fuel",NewFuel,true)
						end
					end
				else
					SetVehicleEngineOn(Vehicle,false,true,true)
					TimeDistance = 1
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:SUPPLY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("engine:Supply",function(Entitys)
	if VehicleFuel then
		return false
	end

	local Ped = PlayerPedId()
	local Vehicle = Entitys[3]
	local Gallons = Entitys[6]
	local VehicleState = Entity(Vehicle).state

	if not VehicleState.Fuel then
		VehicleState:set("Fuel",100.0,true)
	end

	Lasted = VehicleState.Fuel
	if Lasted > 99.980 then
		return false
	end

	AttachVehicle(Vehicle)

	local Coords = GetEntityCoords(Vehicle)

	if not Display and not Gallons then
		SendNUIMessage({ Action = "Open" })
		TriggerEvent("hud:Active",false)
		Display = true
	end

	if not VehicleFuel then
		TaskTurnPedToFaceEntity(Ped,Vehicle,5000)
		VehicleFuel = Lasted
	end

	while VehicleFuel do
		for _,v in ipairs({ 18,22,23,24,29,30,31,140,141,142,143,257,263 }) do
			DisableControlAction(0,v,true)
		end

		if not Gallons then
			Price += 0.2
			VehicleFuel += 0.02
			SendNUIMessage({ Action = "Tank", Payload = { floor(VehicleFuel),Price,0.8 } })
		else
			local Ammo = GetAmmoInPedWeapon(Ped,883325847)
			if Ammo > 2 then
				SetPedAmmo(Ped,883325847,math.floor(Ammo - 2))
				VehicleFuel += 0.02
			end
		end

		SetDrawOrigin(Coords.x,Coords.y,Coords.z)
		DrawSprite("Textures","E",0.0,0.0,0.02,0.02 * GetAspectRatio(false),0.0,255,255,255,255)
		ClearDrawOrigin()

		if not IsEntityPlayingAnim(Ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) and LoadAnim("timetable@gardener@filling_can") then
			TaskPlayAnim(Ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",8.0,8.0,-1,50,1,0,0,0)
		end

		if (VehicleFuel >= 100.0 or GetEntityHealth(Ped) <= 100 or (Gallons and GetAmmoInPedWeapon(Ped,883325847) <= 2) or IsControlJustPressed(1,38)) then
			if LocalPlayer["state"]["HandPumpAttached"] then
				DetatchVehicle()
			end
			if not Gallons and not vSERVER.RechargeFuel(Price) then
				VehicleState:set("Fuel",Lasted,true)
				TriggerEvent("Notify","Aviso","Dinheiro insuficiente.","amarelo",5000)
			else
				VehicleState:set("Fuel",VehicleFuel,true)

				if Display then
					SendNUIMessage({ Action = "Close" })
					TriggerEvent("hud:Active",true)
				end
			end

			VehicleFuel = false
			Display = false
			vRP.Destroy()
			Lasted = 0
			Price = 0
		end

		Wait(1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:VEHRIFY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("engine:Vehrify",function(Entitys)
	local Vehicle = Entitys[3]

	local Mods = {
		{ Number = 11, Name = "Motor" },
		{ Number = 12, Name = "Freios" },
		{ Number = 13, Name = "Transmissão" },
		{ Number = 15, Name = "Suspensão" },
		{ Number = 16, Name = "Blindagem" }
	}

	for _,v in ipairs(Mods) do
		local CurrentMod = GetVehicleMod(Vehicle,v.Number)
		if CurrentMod ~= -1 then
			local Total = GetNumVehicleMods(Vehicle,v.Number)
			exports["dynamic"]:AddButton(v.Name,("Modificação atual instalada: <rare>%d</rare> / %d"):format(CurrentMod + 1,Total),"","",false,false)
		end
	end

	local Force = parseInt(GetVehicleEngineHealth(Vehicle) / 10)
	exports["dynamic"]:AddButton("Potência",("Potência do motor se encontra em <rare>%d%%</rare>."):format(Force),"","",false,false)

	local Body = parseInt(GetVehicleBodyHealth(Vehicle) / 10)
	exports["dynamic"]:AddButton("Lataria",("Qualidade da lataria se encontra em <rare>%d%%</rare>."):format(Body),"","",false,false)

	local Health = parseInt(GetEntityHealth(Vehicle) / 10)
	exports["dynamic"]:AddButton("Chassi",("Rigidez do chassi se encontra em <rare>%d%%</rare>."):format(Health),"","",false,false)

	exports["dynamic"]:Open()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:TAKEPUMP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:TakePump")
AddEventHandler("engine:TakePump", function(Entity)
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local PedNetwork = NetworkGetNetworkIdFromEntity(Ped)
	if not LocalPlayer["state"]["HandPumpOnHand"] then
		LocalPlayer["state"]["HandPumpOnHand"] = true
		local PumpId = Entity[1]
		local Hash = Entity[2]
		ActivePumpCoords = Entity[4]
		
		if not Entity[4] then
			if #(Coords - vec3(-508.779999, -2374.899902, 12.930000)) <= 3.5 then
				PumpId = 582914
				Hash = -469694731
				ActivePumpCoords = vec3(-508.779999, -2374.899902, 12.930000)
			end
		end

		local PumpZOffset = Offsets[Hash]
		NozzleId,NozzleNetwork = CreateHandPump()
	
		TriggerServerEvent("engine:CreateRope",PumpZOffset,PedNetwork,NozzleNetwork)
		table.insert(Tables["Attributes"], { PumpZOffset = PumpZOffset, PedNetwork = PedNetwork, NozzleNetwork = NozzleNetwork })
	else
		LocalPlayer["state"]["HandPumpOnHand"] = false
		TriggerServerEvent("engine:RemoveRope",PedNetwork)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:CREATEROPE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:CreateRope")
AddEventHandler("engine:CreateRope", function(PumpZOffset,PedNetwork,NozzleNetwork)
    local Timeout = GetGameTimer() + 5000
    while not LocalPlayer["state"]?["Ropes"]
        or not NetworkDoesNetworkIdExist(PedNetwork)
            and Timeout > GetGameTimer() do
        Wait(1)
    end
    local Ped = NetworkGetEntityFromNetworkId(PedNetwork)
    local NozzleId = NetworkGetEntityFromNetworkId(NozzleNetwork)
    local NearestPump = FindFuelPump(Ped)
    if NearestPump then
        PumpId = NearestPump["prop"]
    end
    Ropes(PedNetwork,PumpId,NozzleId,PumpZOffset)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROPES
-----------------------------------------------------------------------------------------------------------------------------------------
function Ropes(PedNetwork,PumpId,NozzleId,PumpZOffset)
	local PumpCoords = GetOffsetFromEntityInWorldCoords(PumpId, 0.0, 0.0, PumpZOffset)
	local NozzleCoords = GetOffsetFromEntityInWorldCoords(NozzleId, 0.0, -0.02, -0.175)

	local InitLength = 3.5
	local RopeType = 1
	local MaxLength = 10.0
	local MinLength = 0.5
	
	RopeLoadTextures()
	while not RopeAreTexturesLoaded() do
		RopeLoadTextures()
		Wait(1000)
	end

	local RopeId = AddRope(PumpCoords["x"],PumpCoords["y"],PumpCoords["z"],0.0,0.0,0.0,InitLength,RopeType,MaxLength,MinLength,1.0,false,false,false,5.0,false,0)
	AttachEntitiesToRope(RopeId,PumpId,NozzleId,PumpCoords["x"],PumpCoords["y"],PumpCoords["z"],NozzleCoords["x"],NozzleCoords["y"],NozzleCoords["z"],MaxLength,false,false,"","")
	table.insert(Tables["RopeHandles"], { id = RopeId, index = #Tables["RopeHandles"] + 1, PedNetwork = PedNetwork })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEHANDPUMP
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateHandPump()
	local Ped = PlayerPedId()
	local PedCoords = GetEntityCoords(Ped)
	local objNet = vRPS.CreateObject("prop_cs_fuel_nozle",PedCoords["x"],PedCoords["y"],PedCoords["z"])
	if objNet then
		local spawnObjects = 0
		NozzleId = NetworkGetEntityFromNetworkId(objNet)
		while not DoesEntityExist(NozzleId) and spawnObjects <= 1000 do
			NozzleId = NetworkGetEntityFromNetworkId(objNet)
			spawnObjects = spawnObjects + 1
			Wait(1)
		end

		spawnObjects = 0
		local objectControl = NetworkRequestControlOfEntity(NozzleId)
		while not objectControl and spawnObjects <= 1000 do
			objectControl = NetworkRequestControlOfEntity(NozzleId)
			spawnObjects = spawnObjects + 1
			Wait(1)
		end

		AttachPlayer()
		SetEntityAsNoLongerNeeded(NozzleId)

		return NozzleId,objNet
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTACHPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function AttachPlayer()
	local Ped = PlayerPedId()
	AttachEntityToEntity(NozzleId, Ped, GetPedBoneIndex(Ped, 60309), 0.055, 0.05, 0.0, -50.0, -90.0, -50.0, true, true, false, true, 0, true)
	CreateThread(function()
		while LocalPlayer["state"]["HandPumpOnHand"] do
			Wait(250)
			local PedCoords = GetEntityCoords(Ped)
			
			local Distance = #(PedCoords - ActivePumpCoords)
			if Distance > 15.0 then
				TriggerEvent("inventory:Explosion",ActivePumpCoords)
				LocalPlayer["state"]["HandPumpOnHand"] = false
				local PedNetwork = NetworkGetNetworkIdFromEntity(Ped)
				TriggerServerEvent("engine:RemoveRope",PedNetwork)
			end
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTACHVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function AttachVehicle(Vehicle)
	DetachEntity(NozzleId, true, true)
	local Ped = PlayerPedId()
	local PedCoords = GetEntityCoords(Ped)
	local TankIndex = GetEntityBoneIndexByName(Vehicle,"petroltank")
	local TankCoords = GetWorldPositionOfEntityBone(Vehicle,TankIndex)
	local WheelLeftIndex = GetEntityBoneIndexByName(Vehicle,"wheel_lr")
	local WheelLeftCoords = GetWorldPositionOfEntityBone(Vehicle,WheelLeftIndex)
	local WheelRightIndex = GetEntityBoneIndexByName(Vehicle,"wheel_rr")
	local WheelRightCoords = GetWorldPositionOfEntityBone(Vehicle,WheelRightIndex)
	local DistanceTank = #(PedCoords - TankCoords)
	local DistanceWheelLeft = #(PedCoords - WheelLeftCoords)
	local DistanceWheelRight = #(PedCoords - WheelRightCoords)
	local num = -45.0
	local _,_,_,_,_,_,vehClass = vRP.VehicleList(4)
	if vehClass == 8 then
		if DistanceTank <= 2.0 then
			if TankIndex ~= -1 then
				num = -50.0
				local Offset = GetOffsetFromEntityGivenWorldCoords(Vehicle,TankCoords["x"], TankCoords["y"], TankCoords["z"])
				AttachEntityToEntity(NozzleId, Vehicle, -1, Offset["x"], Offset["y"], Offset["z"] + 0.10, num, 0.0, -90.0, true, true, false, false, 0, true)
				goto states
			end
		end
	else
		if DistanceWheelLeft <= 2.0 then
			if WheelLeftIndex ~= 1 then
				local Offset = GetOffsetFromEntityGivenWorldCoords(Vehicle,WheelLeftCoords["x"], WheelLeftCoords["y"], WheelLeftCoords["z"])
				AttachEntityToEntity(NozzleId, Vehicle, -1, Offset["x"], Offset["y"], Offset["z"] + 0.65, num, 0.0, -90.0, true, true, false, false, 0, true)
				goto states
			end
		end
		if DistanceWheelRight <= 2.0 then
			if WheelRightIndex ~= 1 then
				local Offset = GetOffsetFromEntityGivenWorldCoords(Vehicle,WheelRightCoords["x"], WheelRightCoords["y"], WheelRightCoords["z"])
				AttachEntityToEntity(NozzleId, Vehicle, -1, Offset["x"], Offset["y"], Offset["z"] + 0.65, num, 0.0, 90.0, true, true, false, false, 0, true)
				goto states
			end
		end
	end
	::states::
	LocalPlayer["state"]["HandPumpAttached"] = true
	LocalPlayer["state"]["HandPumpOnHand"] = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DETATCHVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function DetatchVehicle()
	DetachEntity(NozzleId, true, true);
	AttachPlayer()
	LocalPlayer["state"]["HandPumpAttached"] = false
	LocalPlayer["state"]["HandPumpOnHand"] = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:REMOVEROPE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:RemoveRope")
AddEventHandler("engine:RemoveRope", function(PedNetwork)
	for k,v in pairs(Tables["Attributes"]) do
		if v["PedNetwork"] == PedNetwork then
			local NozzleId = NetworkGetEntityFromNetworkId(v["NozzleNetwork"])
			if DoesEntityExist(NozzleId) then
				TriggerServerEvent("DeleteObject",v["NozzleNetwork"])
				table.remove(Tables["Attributes"], k)
			end
		end
	end
	for k,v in pairs(Tables["RopeHandles"]) do
		if v["PedNetwork"] == PedNetwork then
			table.remove(Tables["RopeHandles"], v["index"])
			DeleteRope(v["id"])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYENUMERATOR
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITIESENUMERATE
-----------------------------------------------------------------------------------------------------------------------------------------
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end

        local enum = { handle = iter, destructor = disposeFunc }
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENUMERATEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDFUELPUMP
-----------------------------------------------------------------------------------------------------------------------------------------
function FindFuelPump(Ped)
    local nearestFuelPump = { prop = 0, distance = 3 }
    local position = GetEntityCoords(Ped)
	for prop in EnumerateObjects() do
        if Offsets[GetEntityModel(prop)] then
            local propPos = GetEntityCoords(prop)
            local distance = #(position - propPos)
            if distance < nearestFuelPump.distance then
                nearestFuelPump = { prop = prop, distance = distance }
            end
        end
    end
    return nearestFuelPump
end
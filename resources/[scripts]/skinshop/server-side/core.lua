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
vCLIENT = Tunnel.getInterface("skinshop")
Tunnel.bindInterface("skinshop",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local Locations = {
	{ Coords = vec3(71.29,-1398.68,29.37) },
	{ Coords = vec3(-708.56,-160.5,37.41) },
	{ Coords = vec3(-158.76,-296.94,39.73) },
	{ Coords = vec3(-829.08,-1073.27,11.32) },
	{ Coords = vec3(-1192.23,-771.74,17.32) },
	{ Coords = vec3(-1456.98,-241.17,49.81) },
	{ Coords = vec3(11.87,6513.59,31.88) },
	{ Coords = vec3(1696.92,4829.24,42.06) },
	{ Coords = vec3(122.93,-221.48,54.56) },
	{ Coords = vec3(617.77,2761.81,42.09) },
	{ Coords = vec3(1190.79,2714.29,38.22) },
	{ Coords = vec3(-3173.28,1046.04,20.86) },
	{ Coords = vec3(-1108.61,2709.59,19.11) },
	{ Coords = vec3(429.67,-800.14,29.49) },
	{ Coords = vec3(480.78,-1009.08,30.68) },
	{ Coords = vec3(474.41,-992.92,30.68) }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckPermission(Table)
	local source = source
	local Passport = vRP.Passport(source)

	return Passport and vRP.HasTable(Passport,Table) and true or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Update(Clothes)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Clothings", Information = json.encode(Clothes) })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:SEND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("skinshop:Send")
AddEventHandler("skinshop:Send",function()
	local source = source
	local Passport = vRP.Passport(source)

	if not Passport then
		return false
	end

	local OtherSource = vRPC.ClosestPed(source)
	if not OtherSource or vRP.GetHealth(OtherSource) <= 100 then
		return false
	end

	if vRP.ModelPlayer(source) ~= vRP.ModelPlayer(OtherSource) then
		TriggerClientEvent("Notify",source,"Aviso","Vestimentas recusada.","amarelo",5000)
		return false
	end

	if vRP.Request(OtherSource,false,"Aceitar vestimentas de <b>"..vRP.FullName(Passport).."</b>?") then
		TriggerClientEvent("Notify",source,"Sucesso","Vestimentas enviada.","verde",5000)
		TriggerClientEvent("skinshop:Apply",OtherSource,vCLIENT.CurrentClothes(source),true)
	else
		TriggerClientEvent("Notify",source,"Aviso","Vestimentas recusada.","amarelo",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("skinshop:Remove")
AddEventHandler("skinshop:Remove",function(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local ClosestPed = vRPC.ClosestPed(source)
		if ClosestPed and vRP.HasService(Passport,"Emergencia") then
			TriggerClientEvent("skinshop:set"..Mode,ClosestPed)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINITSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Consult = vRP.Query("entitydata/GetData",{ Name = "Skinshop" })
	local Result = Consult and Consult[1] and json.decode(Consult[1].Information) or {}

	for _,v in pairs(Result) do
		table.insert(Locations,v)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Add",function(Table)
	local Consult = vRP.Query("entitydata/GetData",{ Name = "Skinshop" })
	local Result = Consult and Consult[1] and json.decode(Consult[1].Information) or {}

	table.insert(Result,Table)
	table.insert(Locations,Table)

	TriggerClientEvent("skinshop:Insert",-1,Table)
	vRP.Query("entitydata/SetData",{ Name = "Skinshop", Information = json.encode(Result) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("skinshop:Init",source,Locations)
end)
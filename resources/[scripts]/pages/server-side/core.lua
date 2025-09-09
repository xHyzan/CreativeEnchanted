-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("pages",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Pages = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local Consult = vRP.SingleQuery("entitydata/GetData", { Name = "Pages" })
    if Consult then
        local Items = json.decode(Consult.Information) or {}
        for Serial,Item in pairs(Items) do
            Pages[Serial] = Item
        end

        TriggerClientEvent("pages:Table",-1,Pages)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERCOMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pages",function(source,Message)
	local Passport = vRP.Passport(source)
	if not (Passport and vRP.HasGroup(Passport,"Admin",1)) then return end

	local Keyboard = vKEYBOARD.Tertiary(source,"Coords","Distância","Link")
	if not Keyboard then return end

	local Split = splitString(Keyboard[1],",")
	local x,y,z = tonumber(Split[1]), tonumber(Split[2]), tonumber(Split[3])
	if not (x and y and z) then return end

	local Distance = tonumber(Keyboard[2]) or 2.0
	local Image = Keyboard[3]

	local Selected = GenerateString("DDLLDDLL")
	repeat
		Selected = GenerateString("DDLLDDLL")
	until Selected and not Pages[Selected]

	Pages[Selected] = { Route = GetPlayerRoutingBucket(source), Image = Image, Coords = { x, y, z }, Distance = Distance, }

	TriggerClientEvent("pages:New",-1,Selected,Pages[Selected])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("pages:Delete")
AddEventHandler("pages:Delete",function(Selected)
    local source = source
    local Passport = vRP.Passport(source)
    if not (Passport and vRP.HasGroup(Passport,"Admin",1)) or not Pages[Selected] then return end

    Pages[Selected] = nil
    TriggerClientEvent("pages:Remove",-1,Selected)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Source)
    TriggerClientEvent("pages:Table",Source,Pages)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer",function(Silenced)
	vRP.Query("entitydata/SetData",{ Name = "Pages", Information = json.encode(Pages) })

	if not Silenced then
		print("O resource ^2Pages^7 salvou os dados.")
	end
end)
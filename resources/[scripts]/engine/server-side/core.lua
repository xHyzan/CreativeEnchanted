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
Tunnel.bindInterface("engine",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RechargeFuel(Price)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Price and vRP.PaymentFull(Passport,Price) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEROPE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("engine:CreateRope")
AddEventHandler("engine:CreateRope", function(PumpZOffset, PedNetwork, NozzleNetwork)
    Player(source)["state"]:set("Ropes", true, true)
    TriggerClientEvent("engine:CreateRope", -1, PumpZOffset, PedNetwork, NozzleNetwork)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEROPE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("engine:RemoveRope")
AddEventHandler("engine:RemoveRope", function(PedNetwork)
    Player(source)["state"]:set("Ropes", false, false)
    TriggerClientEvent("engine:RemoveRope", -1, PedNetwork)
end)
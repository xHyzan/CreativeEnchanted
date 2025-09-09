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
Tunnel.bindInterface("inspect",Creative)
vCLIENT = Tunnel.getInterface("inspect")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Admin = {}
local Players = {}
local Sourcers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("inv",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and not Admin[Passport] and parseInt(Message[1]) > 0 and vRP.HasGroup(Passport,"Admin") then
		local OtherPassport = Message[1]
		local OtherSource = vRP.Source(OtherPassport)
		if OtherSource and OtherPassport and OtherPassport ~= Passport and vRP.DoesEntityExist(OtherSource) and not Players[OtherPassport] then
			Admin[Passport] = true
			Sourcers[Passport] = OtherSource
			Players[Passport] = OtherPassport

			TriggerClientEvent("inspect:Open",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSPECT:PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inspect:Player")
AddEventHandler("inspect:Player",function(OtherSource)
	local source = source
	local Passport = vRP.Passport(source)
	local OtherPassport = vRP.Passport(OtherSource)
	if Passport and vRP.DoesEntityExist(OtherSource) and not Players[OtherPassport] and (vRP.HasService(Passport,"Policia") or vRP.GetHealth(OtherSource) <= 100 or (vRP.GetHealth(OtherSource) > 100 and vRP.Request(OtherSource,"Revistar","Você aceita ser revistado?"))) then
		if #(vRP.GetEntityCoords(source) - vRP.GetEntityCoords(OtherSource)) <= 2 then
			Sourcers[Passport] = OtherSource
			Players[Passport] = OtherPassport

			TriggerEvent("inventory:ServerCarry",source,Passport,OtherSource,true)
			TriggerClientEvent("inventory:Close",OtherSource)
			TriggerClientEvent("inspect:Open",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Mount()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Primary = {}
		local Inv = vRP.Inventory(Passport)
		for Slot,v in pairs(Inv) do
			if v.amount <= 0 or not ItemExist(v.item) then
				vRP.CleanSlot(Passport,Slot)
			else
				v.key = v.item

				local Split = splitString(v.item)
				local Item = Split[1]

				if not v.desc then
					if Item == "vehiclekey" and Split[3] then
						local Consult = exports["oxmysql"]:single_async("SELECT * FROM vehicles WHERE Plate = ? LIMIT 1",{ Split[3] })
						if Consult and VehicleExist(Consult.Vehicle) then
							v.desc = "Proprietário: <common>"..vRP.FullName(Consult.Passport).."</common><br>Modelo: <common>"..VehicleName(Consult.Vehicle).."</common><br>Placa: <common>"..Split[3].."</common>"
						end
					elseif Item == "propertys" and Split[2] then
						local Consult = exports["oxmysql"]:single_async("SELECT * FROM propertys WHERE Serial = ? LIMIT 1",{ Split[2] })
						if Consult then
							v.desc = "Proprietário: <common>"..vRP.FullName(Consult.Passport).."</common>"
						end
					elseif ItemNamed(Item) and Split[2] and vRP.Identity(Split[2]) then
						if Item == "identity" then
							v.desc = "Passaporte: <rare>"..Dotted(Split[2]).."</rare><br>Nome: <rare>"..vRP.FullName(Split[2]).."</rare><br>Telefone: <rare>"..vRP.Phone(Split[2]).."</rare>"
						else
							v.desc = "Proprietário: <common>"..vRP.FullName(Split[2]).."</common>"
						end
					end
				end

				if Split[2] then
					local Loaded = ItemLoads(v.item)
					if Loaded then
						v.charges = parseInt(Split[2] * (100 / Loaded))
					end

					if ItemDurability(v.item) then
						v.durability = parseInt(os.time() - Split[2])
						v.days = ItemDurability(v.item)
					end
				end

				Primary[Slot] = v
			end
		end

		local Secondary = {}
		local Inv = vRP.Inventory(Players[Passport])
		for Slot,v in pairs(Inv) do
			if v.amount <= 0 or not ItemExist(v.item) then
				vRP.CleanSlot(Players[Passport],Slot)
			else
				v.key = v.item

				local Split = splitString(v.item)
				local Item = Split[1]

				if not v.desc then
					if Item == "vehiclekey" and Split[3] then
						local Consult = exports["oxmysql"]:single_async("SELECT * FROM vehicles WHERE Plate = ? LIMIT 1",{ Split[3] })
						if Consult and VehicleExist(Consult.Vehicle) then
							v.desc = "Proprietário: <common>"..vRP.FullName(Consult.Passport).."</common><br>Modelo: <common>"..VehicleName(Consult.Vehicle).."</common><br>Placa: <common>"..Split[3].."</common>"
						end
					elseif Item == "propertys" and Split[2] then
						local Consult = exports["oxmysql"]:single_async("SELECT * FROM propertys WHERE Serial = ? LIMIT 1",{ Split[2] })
						if Consult then
							v.desc = "Proprietário: <common>"..vRP.FullName(Consult.Passport).."</common>"
						end
					elseif ItemNamed(Item) and Split[2] and vRP.Identity(Split[2]) then
						if Item == "identity" then
							v.desc = "Passaporte: <rare>"..Dotted(Split[2]).."</rare><br>Nome: <rare>"..vRP.FullName(Split[2]).."</rare><br>Telefone: <rare>"..vRP.Phone(Split[2]).."</rare>"
						else
							v.desc = "Proprietário: <common>"..vRP.FullName(Split[2]).."</common>"
						end
					end
				end

				if Split[2] then
					local Loaded = ItemLoads(v.item)
					if Loaded then
						v.charges = parseInt(Split[2] * (100 / Loaded))
					end

					if ItemDurability(v.item) then
						v.durability = parseInt(os.time() - Split[2])
						v.days = ItemDurability(v.item)
					end
				end

				Secondary[Slot] = v
			end
		end

		return Primary,Secondary,vRP.GetWeight(Passport),vRP.GetWeight(Players[Passport])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Reset()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Sourcers[Passport] then
			if vRP.DoesEntityExist(Sourcers[Passport]) and not Admin[Passport] then
				TriggerEvent("inventory:ServerCarry",source,Passport,Sourcers[Passport])
			end

			Sourcers[Passport] = nil
		end

		if Players[Passport] then
			Players[Passport] = nil
		end

		if Admin[Passport] then
			Admin[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Store(Item,Slot,Amount,Target)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Sourcers[Passport] and vRP.DoesEntityExist(Sourcers[Passport]) then
		if BlockDelete(Item) or vRP.MaxItens(Players[Passport],Item,Amount) then
			TriggerClientEvent("inventory:Update",source)

			return false
		end

		if (vRP.InventoryWeight(Players[Passport]) + ItemWeight(Item) * Amount) <= vRP.GetWeight(Players[Passport]) then
			if vRP.TakeItem(Passport,Item,Amount,true,Slot) and vRP.GiveItem(Players[Passport],Item,Amount,true,Target) then
				TriggerClientEvent("inventory:Update",source)
			else
				if ItemType(Item) == "Armamento" then
					TriggerClientEvent("inventory:Update",source)
				end
			end
		else
			TriggerClientEvent("inventory:Notify",source,"Aviso","Mochila Sobrecarregada.","amarelo")
			TriggerClientEvent("inventory:Update",source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Take(Item,Slot,Target,Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Sourcers[Passport] and vRP.DoesEntityExist(Sourcers[Passport]) then
		if BlockDelete(Item) or vRP.MaxItens(Passport,Item,Amount) then
			TriggerClientEvent("inventory:Update",source)

			return false
		end

		if vRP.CheckWeight(Passport,Item,Amount) then
			if vRP.TakeItem(Players[Passport],Item,Amount,true,Slot) and vRP.GiveItem(Passport,Item,Amount,true,Target) then
				TriggerClientEvent("inventory:Update",source)
			else
				if ItemType(Item) == "Armamento" then
					TriggerClientEvent("inventory:Update",source)
				end
			end
		else
			TriggerClientEvent("inventory:Notify",source,"Aviso","Mochila Sobrecarregada.","amarelo")
			TriggerClientEvent("inventory:Update",source)
		end
	end
end
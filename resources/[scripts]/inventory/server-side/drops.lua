-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Reserved = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer",function(Silenced)
	if Silenced then
		return false
	end

	for Route,Table in pairs(Drops) do
		for Number,v in pairs(Table) do
			local Exist = Drops[Route] and Drops[Route][Number]
			if Exist then
				if Exist.key and ItemUnique(Exist.key) then
					local Unique = SplitUnique(Exist.key)
					if Unique then
						vRP.RemSrvData(Unique)
					end
				end

				TriggerClientEvent("inventory:DropsRemover",-1,Route,Number)
				Drops[Route][Number] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Drops(Item,Slot,Amount)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Amount >= 1 and not Player(source)["state"]["Handcuff"] and not exports["hud"]:Wanted(Passport) and not vRP.InsideVehicle(source) then
		if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
			return exports["inventory"]:Drops(Passport,source,Item,Amount,true)
		else
			TriggerClientEvent("inventory:Update",source)
		end
	else
		TriggerClientEvent("inventory:Update",source)
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Drops",function(Passport,source,Item,Amount,Force,Coords)
	if Amount >= 1 then
		local Item = Item
		local Force = Force
		local source = source
		local Passport = Passport
		local Amount = parseInt(Amount)
		local Route = GetPlayerRoutingBucket(source)

		Active[Passport] = true

		Force = (Force and Item or vRP.SortNameItem(Passport,Item))

		if not Drops[Route] then
			Drops[Route] = {}
		end

		repeat
			Selected = GenerateString("DDDDDDDDD")
		until Selected and not Reserved[Selected] and not Drops[Route][Selected]
		Reserved[Selected] = true

		local Provisory = {
			["key"] = Force,
			["route"] = Route,
			["id"] = Selected,
			["amount"] = Amount,
			["coords"] = Coords or vRP.GetEntityCoords(source)
		}

		local Split = splitString(Force)
		local Item = Split[1]

		if not Provisory.desc then
			if Item == "vehiclekey" and Split[3] then
				local Consult = exports["oxmysql"]:single_async("SELECT * FROM vehicles WHERE Plate = ? LIMIT 1",{ Split[3] })
				if Consult and VehicleExist(Consult.Vehicle) then
					Provisory.desc = "Proprietário: <common>"..vRP.FullName(Consult.Passport).."</common><br>Modelo: <common>"..VehicleName(Consult.Vehicle).."</common><br>Placa: <common>"..Split[3].."</common>"
				end
			elseif Item == "propertys" and Split[2] then
				local Consult = exports["oxmysql"]:single_async("SELECT * FROM propertys WHERE Serial = ? LIMIT 1",{ Split[2] })
				if Consult then
					Provisory.desc = "Proprietário: <common>"..vRP.FullName(Consult.Passport).."</common>"
				end
			elseif ItemNamed(Item) and Split[2] and vRP.Identity(Split[2]) then
				if Item == "identity" then
					Provisory.desc = "Passaporte: <rare>"..Dotted(Split[2]).."</rare><br>Nome: <rare>"..vRP.FullName(Split[2]).."</rare><br>Telefone: <rare>"..vRP.Phone(Split[2]).."</rare>"
				else
					Provisory.desc = "Proprietário: <common>"..vRP.FullName(Split[2]).."</common>"
				end
			end
		end

		if Split[2] then
			local Loaded = ItemLoads(Force)
			if Loaded then
				Provisory["charges"] = parseInt(Split[2] * (100 / Loaded))
			end

			local Durability = ItemDurability(Force)
			if Durability then
				Provisory["durability"] = parseInt(os.time() - Split[2])
				Provisory["days"] = Durability
			end
		end

		Active[Passport] = nil
		Drops[Route][Selected] = Provisory
		TriggerClientEvent("inventory:DropsAdicionar",-1,Route,Selected,Drops[Route][Selected])

		return true
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Pickup(Number,Route,Target,Amount)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Drops[Route] and Drops[Route][Number] and Drops[Route][Number]["key"] then
		Active[Passport] = true

		if vRP.CheckWeight(Passport,Drops[Route][Number]["key"],Amount) then
			local Inv = vRP.Inventory(Passport)
			if not Drops[Route] or not Drops[Route][Number] or not Drops[Route][Number]["key"] or not Drops[Route][Number]["amount"] or Drops[Route][Number]["amount"] < Amount or (Inv[Target] and Inv[Target]["item"] ~= Drops[Route][Number]["key"]) or vRP.MaxItens(Passport,Drops[Route][Number]["key"],Amount) then
				TriggerClientEvent("inventory:Notify",source,"Aviso","Mochila Sobrecarregada.","amarelo")
			else
				if vRP.GiveItem(Passport,Drops[Route][Number]["key"],Amount,false,Target) then
					Drops[Route][Number]["amount"] = Drops[Route][Number]["amount"] - Amount

					if Drops[Route] and Drops[Route][Number] and Drops[Route][Number]["amount"] then
						if parseInt(Drops[Route][Number]["amount"]) <= 0 then
							TriggerClientEvent("inventory:DropsRemover",-1,Route,Number)
							Drops[Route][Number] = nil
						else
							TriggerClientEvent("inventory:DropsAtualizar",-1,Route,Number,Drops[Route][Number]["amount"])
						end
					end

					Active[Passport] = nil

					return true
				end
			end
		else
			TriggerClientEvent("inventory:Notify",source,"Aviso","Mochila Sobrecarregada.","amarelo")
		end

		TriggerClientEvent("inventory:Update",source)
		Active[Passport] = nil
	end

	return false
end
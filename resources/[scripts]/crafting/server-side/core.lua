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
Tunnel.bindInterface("crafting",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Permission(Name)
	local source = source
	local Passport = vRP.Passport(source)

	return Passport and List[Name] and not exports["bank"]:CheckTaxs(Passport) and not exports["bank"]:CheckFines(Passport) and (not List[Name].Permission or (List[Name].Permission and vRP.HasService(Passport,List[Name].Permission))) or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Mount(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Name and List[Name] then
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

		return Primary,vRP.GetWeight(Passport)
	end
end
---------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Take(Item,Amount,Target,Name)
	local source = source
	local Target = tostring(Target)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Item and Target and List[Name] and List[Name].List and List[Name].List[Item] then
		if Amount > 1 and (ItemUnique(Item) or ItemLoads(Item)) then
			Amount = 1
		end

		if ItemBlueprint(Item) and not exports["inventory"]:Blueprint(Passport,Item) then
			TriggerClientEvent("inventory:Notify",source,"Aviso","Aprendizado não encontrado.","amarelo")

			return false
		end

		local ItemList = {}
		local Inventory = vRP.Inventory(Passport)
		local Multiplier = List[Name].List[Item].Amount * Amount
		if not vRP.MaxItens(Passport,Item,Multiplier) and vRP.CheckWeight(Passport,Item,Multiplier) and (not Inventory[Target] or (Inventory[Target] and Inventory[Target].item == Item)) then
			for Index,Value in pairs(List[Name]["List"][Item]["Required"]) do
				local ConsultItem = vRP.ConsultItem(Passport,Index,Value * Amount)
				if ConsultItem then
					ItemList[ConsultItem.Item] = Value * Amount
				else
					TriggerClientEvent("inventory:Notify",source,"Atenção","Precisa de <default>"..Dotted(Value * Amount).."x "..ItemName(Index).."</default>.","vermelho")
					return false
				end
			end

			for Index,Value in pairs(ItemList) do
				vRP.RemoveItem(Passport,Index,Value)
			end

			vRP.GenerateItem(Passport,Item,Multiplier,false,Target)
		end
	end

	TriggerClientEvent("inventory:Update",source)
end
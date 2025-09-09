-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSKINWEAPON = Tunnel.getInterface("skinweapon")
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

		return Primary,vRP.GetWeight(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLUEPRINT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Blueprint()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Users["Blueprints"][Passport] then
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
		for Item,v in pairs(Users.Blueprints[Passport]) do
			if (not ItemExist(Item) or not ItemExist("blueprint_"..Item)) and Users.Blueprints[Passport][Item] then
				Users.Blueprints[Passport][Item] = nil
			else
				local Calculated = CountTable(Secondary) + 1
				local Number = tostring(Calculated)

				Secondary[Number] = { key = Item, amount = 1 }

				if Crafting[Item] then
					Secondary[Number].required = {}

					for Index,Amount in pairs(Crafting[Item].Required) do
						local Rarity = ItemRarity(Index)

						table.insert(Secondary[Number].required,"<"..Rarity..">"..Dotted(Amount).."x "..ItemName(Index).."</"..Rarity..">")
					end
				end
			end
		end

		return Primary,Secondary,vRP.GetWeight(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Missions()
	local List = {}
	local source = source
	local Passport = vRP.Passport(source)

	if not Passport then
		return List
	end

	local Consult = vRP.SimpleData(Passport,"Missions")
	for Index,v in pairs(Missions) do
		List[Index] = v
		List[Index].Active = Consult and Consult[v.Code] and true or false
	end

	return { vRP.GetExperience(Passport,"Missions"),TableLevel(),List }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESCUEMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RescueMission(Index)
	local source = source
	local Passport = vRP.Passport(source)

	if not Passport or not Missions[Index] then
		return false
	end

	local Code = Missions[Index].Code
	local Consult = vRP.SimpleData(Passport,"Missions")
	if not Code or (Consult and Consult[Code]) then
		return false
	end

	for Item,Amount in pairs(Missions[Index].Required) do
		if not vRP.ConsultItem(Passport,Item,Amount) then
			TriggerClientEvent("inventory:Notify",source,"Atenção","Precisa de <default>"..Dotted(Amount).."x "..ItemName(Item).."</default>.","vermelho")
			return false
		end
	end

	for Item,Amount in pairs(Missions[Index].Required) do
		vRP.RemoveItem(Passport,Item,Amount)
	end

	for Item,Amount in pairs(Missions[Index].Rewards) do
		vRP.GenerateItem(Passport,Item,Amount)
	end

	if Missions[Index].Xp then
		vRP.PutExperience(Passport,"Missions",Missions[Index].Xp)
	end

	Consult = Consult or {}
	Consult[Code] = true

	vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Missions", Information = json.encode(Consult) })

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Crafting(Item,Amount,Target)
	local source = source
	local Target = tostring(Target)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Item and Target and Crafting[Item] then
		if Amount > 1 and (ItemUnique(Item) or ItemLoads(Item)) then
			Amount = 1
		end

		local Inventory = vRP.Inventory(Passport)
		local Multiplier = Crafting[Item].Amount * Amount
		if not vRP.MaxItens(Passport,Item,Multiplier) and vRP.CheckWeight(Passport,Item,Multiplier) and (not Inventory[Target] or (Inventory[Target] and Inventory[Target].item == Item)) then
			for Index,Value in pairs(Crafting[Item].Required) do
				if not vRP.ConsultItem(Passport,Index,Value * Amount) then
					TriggerClientEvent("inventory:Notify",source,"Atenção","Precisa de <default>"..Dotted(Value * Amount).."x "..ItemName(Index).."</default>.","vermelho")

					return false
				end
			end

			for Index,Value in pairs(Crafting[Item].Required) do
				vRP.RemoveItem(Passport,vRP.InventoryItemAmount(Passport,Index)[2],Value * Amount)
			end

			vRP.GenerateItem(Passport,Item,Multiplier,false,Target)
		end
	end

	TriggerClientEvent("inventory:Update",source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERSKINS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.UserSkins()
    local Source = source
    local Passport = vRP.Passport(Source)
    local Identity = vRP.Identity(Passport)
    local Account = vRP.Account(Identity["License"])

    if Passport then
        local SkinsData = vRP.UserData(Passport, "Skins") or {}

        if not SkinsData then
            local Query = vRP.Query("playerdata/GetData", { Passport = Passport, Name = "Skins" })
            if Query[1] and Query[1]["Information"] then
                SkinsData = json.decode(Query[1]["Information"])
            else
                SkinsData = { List = {} }
            end
        end

        if not SkinsData["List"] then
            SkinsData["List"] = {}
        end

        return SkinsData
    end

    return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYSKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.BuySkin(Data)  
    local source = source
    local Passport = vRP.Passport(source)
    local Identity = vRP.Identity(Passport)
    local Account = vRP.Account(Identity["License"])

    if Passport then
        if Account["Gemstone"] >= Data["price"] then
            local SkinsData = vRP.UserData(Passport, "Skins")

            if not SkinsData then
                SkinsData = { List = {} }
            elseif not SkinsData["List"] then
                SkinsData["List"] = {}
            end

            local Price = Data["price"]

            for k,v in pairs(SkinsData["List"]) do
                if v == Data["id"] then
                    TriggerClientEvent("Notify", source, "Aviso", "Você já possui esta skin.", "vermelho", 15000, "center")        

                    return false
                end
            end

            if vRP.Request(source,"Sistema de compra de skins de armas","Você realmente deseja comprar a skin de arma <b>"..Data["name"].."</b> para a arma <b>"..Data["description"].."</b>?") then
                if vRP.PaymentGems(Passport, Price) then
                    table.insert(SkinsData["List"], Data["id"])
                    vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Skins", Information = json.encode(SkinsData) })
                    TriggerClientEvent("Notify", source, "Sucesso", "Skin adquirida com sucesso.", "verde", 5000)
                else
                    TriggerClientEvent("Notify", source, "Aviso", "Você não possui gemas o suficiente.", "vermelho", 5000) 
                end
            end
    
            return true
        end
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ToggleSkin(Weapon, Component)
    local Source = source
    local Passport = vRP.Passport(Source)

    if Passport then
        if Weapon then
            local SkinsData = vRP.UserData(Passport, "Skins")
    
            SkinsData[Weapon] = Component
    
            vRP.Query("playerdata/GetData",{ Passport = Passport, Name = "Skins", Information = json.encode(SkinsData) })
    
            return true
        end
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERSKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.TransferSkin(Target, Number, Weapon, Component)
    local source = source
    local Passport = vRP.Passport(source)
    local OtherPassport = parseInt(Target)
    local OtherSource = vRP.Source(OtherPassport)
    local Name = nil

    if Passport then
        if OtherSource and Number and Weapon and Component then
            local SkinsData = vRP.UserData(Passport, "Skins") or {}
            local TargetSkinsData = vRP.UserData(OtherPassport, "Skins") or {}

            if not TargetSkinsData["List"] then
                TargetSkinsData["List"] = {}
            end

            for k, v in pairs(vSKINWEAPON.Weapons(source)) do
                if v["weapon"] == Weapon and v["component"] == Component then
                    Name = v["name"]
                end
            end

            if vRP.Request(source,"Sistema de transferência de skins de armas","Você realmente deseja transferir a skin de arma <b>"..Name.."</b> para o jogador <b>"..vRP.FullName(OtherPassport).."</b>?") then
                for k,v in pairs(TargetSkinsData["List"]) do
                    if v == Number then
                        TriggerClientEvent("Notify", source, "Aviso", "O jogador já possui esta Skin.", "vermelho", 5000)        

                        return false
                    end
                end

                for k,v in pairs(SkinsData["List"]) do
                    if v == Number then
                        table.remove(SkinsData["List"], k)
                    end
                end

                table.insert(TargetSkinsData["List"], Number)

                vRP.Query("playerdata/SetData",{ Passport = Target, Name = "Skins", Information = json.encode(TargetSkinsData) })
                vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Skins", Information = json.encode(SkinsData) })
                TriggerClientEvent("Notify", source, "Sucesso", "Você transferiu a skin de arma <b>"..Name.."</b> para o jogador <b>"..vRP.FullName(OtherPassport).."</b>", "verde", 5000)
                TriggerClientEvent("Notify", OtherSource, "Sucesso", "Você recebeu a skin de arma <b>"..Name.."</b> do jogador <b>"..vRP.FullName(Passport).."</b>", "verde", 5000)        

                return true
            end
        elseif not OtherSource then
            TriggerClientEvent("Notify", source, "Aviso", "O jogador não existe ou ele não esta na cidade.", "vermelho", 5000)        

            return false
        end
    end
    
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ActiveSkin(Weapon, Component)
    local source = source
    local Passport = vRP.Passport(source)
    
    if Passport then
        local SkinsData = vRP.UserData(Passport, "Skins")
        local Name = nil
        SkinsData[Weapon] = Component

        if not SkinsData then
            SkinsData = { List = {} }
        elseif not SkinsData["List"] then
            SkinsData["List"] = {}
        end

        if Users["Skins"][Passport] == nil then
            Users["Skins"][Passport] = SkinsData
        end

        Users["Skins"][Passport][Weapon] = Component

        vRP.Query("playerdata/SetData", { Passport = Passport, Name = "Skins", Information = json.encode(SkinsData) })

        for k, v in pairs(vSKINWEAPON.Weapons(source)) do
            if v["weapon"] == Weapon and v["component"] == Component then
                Name = v["name"]
            end
        end

        TriggerClientEvent("Notify", source, "Sucesso", "A skin <b>"..Name.."</b> foi ativada", "verde", 5000)

        return true
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INACTIVESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.InactiveSkin(Weapon, Component)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local SkinsData = vRP.UserData(Passport, "Skins")
        local Name = nil

        if not SkinsData then
            SkinsData = { List = {} }
        elseif not SkinsData["List"] then
            SkinsData["List"] = {}
        end

        if Users["Skins"][Passport] == nil then
            Users["Skins"][Passport] = {}
        end

        SkinsData[Weapon] = nil
        Users["Skins"][Passport][Weapon] = nil
        vRP.Query("playerdata/SetData", { Passport = Passport, Name = "Skins", Information = json.encode(SkinsData) })

        for k, v in pairs(vSKINWEAPON.Weapons(source)) do
            if v["weapon"] == Weapon and v["component"] == Component then
                Name = v["name"]
            end
        end

        TriggerClientEvent("Notify", source, "Sucesso", "A skin <b>"..Name.."</b> foi desativada", "verde", 5000)

        return true
    end
    return false
end
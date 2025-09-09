-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Payments = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
for Number = 1,#Objects do
	GlobalState["Farmer:"..Number] = 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MINERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Minerman")
AddEventHandler("farmer:Minerman",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		if not Number or type(Number) ~= "number" then
			exports["discord"]:Embed("Hackers","**[PASSAPORTE]:** "..Passport.."\n**[FUNÇÃO]:** Payment do Farmer",source)

			Payments[Passport] = (Payments[Passport] or 0) + 1
			if Payments[Passport] >= 3 then
				vRP.SetBanned(Passport,-1,"Permanente","Hacker")
			end
		end

		if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
			local Item = "pickaxe"
			local Pickaxe = vRP.ConsultItem(Passport,Item)
			local PickaxePlus = vRP.ConsultItem(Passport,Item.."plus")

			if not Pickaxe and not PickaxePlus then
				TriggerClientEvent("Notify",source,"Atenção","Precisa de <b>1x "..ItemName(Item).."</b>.","amarelo",5000)
			else
				Player(source)["state"]["Cancel"] = true
				Player(source)["state"]["Buttons"] = true
				vRPC.CreateObjects(source,"melee@large_wpn@streamed_core","ground_attack_on_spot","prop_tool_pickaxe",1,18905,0.10,-0.1,0.0,-92.0,260.0,5.0)

				if vRP.Task(source,Pickaxe and 10 or 5,10000) and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
					GlobalState["Farmer:"..Number] = GlobalState["Work"] + 60

					local Result = {
						{ ["Item"] = "tin_pure", ["Chance"] = 125, ["Min"] = 1, ["Max"] = 1 },
						{ ["Item"] = "lead_pure", ["Chance"] = 125, ["Min"] = 1, ["Max"] = 1 },
						{ ["Item"] = "copper_pure", ["Chance"] = 100, ["Min"] = 1, ["Max"] = 1 },
						{ ["Item"] = "iron_pure", ["Chance"] = 75, ["Min"] = 1, ["Max"] = 1 },
						{ ["Item"] = "gold_pure", ["Chance"] = 75, ["Min"] = 1, ["Max"] = 1 },
						{ ["Item"] = "diamond_pure", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
						{ ["Item"] = "ruby_pure", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 }
					}

					if PickaxePlus then
						Result = {
							{ ["Item"] = "tin_pure", ["Chance"] = 125, ["Min"] = 1, ["Max"] = 1 },
							{ ["Item"] = "lead_pure", ["Chance"] = 125, ["Min"] = 1, ["Max"] = 1 },
							{ ["Item"] = "copper_pure", ["Chance"] = 100, ["Min"] = 1, ["Max"] = 1 },
							{ ["Item"] = "iron_pure", ["Chance"] = 75, ["Min"] = 1, ["Max"] = 1 },
							{ ["Item"] = "gold_pure", ["Chance"] = 75, ["Min"] = 1, ["Max"] = 1 },
							{ ["Item"] = "diamond_pure", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
							{ ["Item"] = "ruby_pure", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
							{ ["Item"] = "sapphire_pure", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
							{ ["Item"] = "emerald_pure", ["Chance"] = 10, ["Min"] = 1, ["Max"] = 1 },
							{ ["Item"] = "chalcopyrite", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
							{ ["Item"] = "bauxite", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 }
						}
					end

					local Consult = RandPercentage(Result)
					if exports["party"]:DoesExist(Passport,2) then
						Consult["Valuation"] = Consult["Valuation"] + (Consult["Valuation"] * 0.5)
					end

					if exports["inventory"]:Buffs("Luck",Passport) then
						Consult["Valuation"] = Consult["Valuation"] + (Consult["Valuation"] * 0.5)
					end

					for Permission,Multiplier in pairs({ Ouro = 0.5, Prata = 0.35, Bronze = 0.2 }) do
						if vRP.HasService(Passport,Permission) then
							Consult["Valuation"] = Consult["Valuation"] + (Consult["Valuation"] * Consult["Valuation"] * Multiplier)
						end
					end

					if vRP.CheckWeight(Passport,Consult["Item"],Consult["Valuation"]) and not vRP.MaxItens(Passport,Consult["Item"],Consult["Valuation"]) then
						vRP.GenerateItem(Passport,Consult["Item"],Consult["Valuation"],true)
					else
						TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
						exports["inventory"]:Drops(Passport,source,Consult["Item"],Consult["Valuation"])
					end

					vRP.BattlepassPoints(Passport,2)
					vRP.UpgradeStress(Passport,1)
				end

				Player(source)["state"]["Buttons"] = false
				Player(source)["state"]["Cancel"] = false
				vRPC.Destroy(source)
			end
		end

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUMBERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Lumberman")
AddEventHandler("farmer:Lumberman",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		if not Number or type(Number) ~= "number" then
			exports["discord"]:Embed("Hackers","**[PASSAPORTE]:** "..Passport.."\n**[FUNÇÃO]:** Payment do Farmer",source)

			Payments[Passport] = (Payments[Passport] or 0) + 1
			if Payments[Passport] >= 3 then
				vRP.SetBanned(Passport,-1,"Permanente","Hacker")
			end
		end

		if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
			local Item = "axe"
			local Axe = vRP.ConsultItem(Passport,Item)
			local AxePlus = vRP.ConsultItem(Passport,Item.."plus")

			if not Axe and not AxePlus then
				TriggerClientEvent("Notify",source,"Atenção","Precisa de <b>1x "..ItemName(Item).."</b>.","amarelo",5000)
			else
				Player(source)["state"]["Cancel"] = true
				Player(source)["state"]["Buttons"] = true
				vRPC.playAnim(source,false,{"lumberjackaxe@idle","idle"},true)

				if vRP.Task(source,Axe and 10 or 5,10000) and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
					GlobalState["Farmer:"..Number] = GlobalState["Work"] + 30

					local Valuation = 3
					if exports["party"]:DoesExist(Passport,2) then
						Valuation = Valuation + (Valuation * 0.25)
					end

					if exports["inventory"]:Buffs("Luck",Passport) then
						Valuation = Valuation + (Valuation * 0.25)
					end

					for Permission,Multiplier in pairs({ Ouro = 0.25, Prata = 0.2, Bronze = 0.15 }) do
						if vRP.HasService(Passport,Permission) then
							Valuation = Valuation + (Valuation * Multiplier)
						end
					end

					if vRP.CheckWeight(Passport,"woodlog",Valuation) and not vRP.MaxItens(Passport,"woodlog",Valuation) then
						vRP.GenerateItem(Passport,"woodlog",Valuation,true)
					else
						TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
						exports["inventory"]:Drops(Passport,source,"woodlog",Valuation)
					end

					vRP.BattlepassPoints(Passport,2)
					vRP.UpgradeStress(Passport,1)
				end

				TriggerClientEvent("inventory:Provisory",source,false)
				Player(source)["state"]["Buttons"] = false
				Player(source)["state"]["Cancel"] = false
				vRPC.Destroy(source)
			end
		end

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSPORTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Transporter")
AddEventHandler("farmer:Transporter",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		if not Number or type(Number) ~= "number" then
			exports["discord"]:Embed("Hackers","**[PASSAPORTE]:** "..Passport.."\n**[FUNÇÃO]:** Payment do Farmer",source)

			Payments[Passport] = (Payments[Passport] or 0) + 1
			if Payments[Passport] >= 3 then
				vRP.SetBanned(Passport,-1,"Permanente","Hacker")
			end
		end

		if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
			Player(source)["state"]["Cancel"] = true
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("Progress",source,"Coletando",1000)
			vRPC.playAnim(source,false,{"pickup_object","pickup_low"},true)

			SetTimeout(1000,function()
				if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
					GlobalState["Farmer:"..Number] = GlobalState["Work"] + 18

					local Valuation = 1
					if exports["inventory"]:Buffs("Luck",Passport) then
						Valuation = Valuation + 1
					end

					if vRP.CheckWeight(Passport,"pouch",Valuation) and not vRP.MaxItens(Passport,"pouch",Valuation) then
						vRP.GenerateItem(Passport,"pouch",Valuation,true)
					else
						TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
						exports["inventory"]:Drops(Passport,source,"pouch",Valuation)
					end

					vRP.UpgradeStress(Passport,1)
				end

				vRPC.Destroy(source)
			end)

			Player(source)["state"]["Buttons"] = false
			Player(source)["state"]["Cancel"] = false
		end

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SANDMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Sandman")
AddEventHandler("farmer:Sandman",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		if not Number or type(Number) ~= "number" then
			exports["discord"]:Embed("Hackers","**[PASSAPORTE]:** "..Passport.."\n**[FUNÇÃO]:** Payment do Farmer",source)

			Payments[Passport] = (Payments[Passport] or 0) + 1
			if Payments[Passport] >= 3 then
				vRP.SetBanned(Passport,-1,"Permanente","Hacker")
			end
		end

		if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
			Player(source)["state"]["Cancel"] = true
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("Progress",source,"Coletando",1000)
			vRPC.playAnim(source,false,{"pickup_object","pickup_low"},true)

			SetTimeout(1000,function()
				if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
					GlobalState["Farmer:"..Number] = GlobalState["Work"] + 30

					local Valuation = 1
					if exports["inventory"]:Buffs("Luck",Passport) then
						Valuation = Valuation + 1
					end

					if vRP.CheckWeight(Passport,"sand",Valuation) and not vRP.MaxItens(Passport,"sand",Valuation) then
						vRP.GenerateItem(Passport,"sand",Valuation,true)
					else
						TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
						exports["inventory"]:Drops(Passport,source,"sand",Valuation)
					end

					vRP.BattlepassPoints(Passport,5)
					vRP.UpgradeStress(Passport,1)
				end

				vRPC.Destroy(source)
			end)

			Player(source)["state"]["Buttons"] = false
			Player(source)["state"]["Cancel"] = false
		end

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRASHER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Trasher")
AddEventHandler("farmer:Trasher",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		if not Number or type(Number) ~= "number" then
			exports["discord"]:Embed("Hackers","**[PASSAPORTE]:** "..Passport.."\n**[FUNÇÃO]:** Payment do Farmer",source)

			Payments[Passport] = (Payments[Passport] or 0) + 1
			if Payments[Passport] >= 3 then
				vRP.SetBanned(Passport,-1,"Permanente","Hacker")
			end
		end

		if not vRPC.LastVehicle(source,"trash") then
			TriggerClientEvent("Notify",source,"Atenção","Necessário a utilização do veículo <b>Trash</b>.","amarelo",5000)
			Active[Passport] = nil

			return false
		end

		if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
			Player(source)["state"]["Cancel"] = true
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("Progress",source,"Coletando",1000)
			vRPC.playAnim(source,false,{"pickup_object","pickup_low"},true)

			Wait(1000)

			if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
				GlobalState["Farmer:"..Number] = GlobalState["Work"] + 180

				if not vRP.MaxItens(Passport,"binbag") and vRP.CheckWeight(Passport,"binbag") then
					vRP.GenerateItem(Passport,"binbag",1,true)
				else
					TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
					exports["inventory"]:Drops(Passport,source,"binbag",1)
				end

				vRP.PutExperience(Passport,"Garbageman",1)
				vRP.BattlepassPoints(Passport,1)
				vRP.UpgradeStress(Passport,1)
			end

			Player(source)["state"]["Buttons"] = false
			Player(source)["state"]["Cancel"] = false
			vRPC.Destroy(source)
		end

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end

	if Payments[Passport] then
		Payments[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("target")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zones = {}
local Models = {}
local Focus = false
local Selected = {}
local Sucess = false
local Actived = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
local Dismantle = {
	vec3(943.23,-1497.87,30.11),
	vec3(-1172.57,-2037.65,13.75),
	vec3(-524.94,-1680.63,19.21),
	vec3(1358.14,-2095.41,52.0),
	vec3(602.47,-437.82,24.75),
	vec3(-413.86,-2179.29,10.31),
	vec3(146.51,320.62,112.14),
	vec3(520.91,169.14,99.36),
	vec3(1137.99,-794.32,57.59),
	vec3(-93.07,-2549.6,6.0),
	vec3(820.07,-488.43,30.46),
	vec3(1078.62,-2325.56,30.25),
	vec3(1204.69,-3116.71,5.50)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWEDSOUTH
-----------------------------------------------------------------------------------------------------------------------------------------
local TowedSouth = PolyZone:Create({
	vec2(409.48,-1629.45),
	vec2(402.95,-1624.08),
	vec2(393.87,-1634.91),
	vec2(400.25,-1640.29)
},{ name = "TowedSouth" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWEDNORTH
-----------------------------------------------------------------------------------------------------------------------------------------
local TowedNorth = PolyZone:Create({
	vec2(1992.2,3777.87),
	vec2(1974.84,3769.01),
	vec2(1966.07,3784.13),
	vec2(1983.1,3793.9)
},{ name = "TowedNorth" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRES
-----------------------------------------------------------------------------------------------------------------------------------------
local Tyres = {
	{ Bone = "wheel_lf", Index = 0 },
	{ Bone = "wheel_rf", Index = 1 },
	{ Bone = "wheel_lm", Index = 2 },
	{ Bone = "wheel_rm", Index = 3 },
	{ Bone = "wheel_lr", Index = 4 },
	{ Bone = "wheel_rr", Index = 5 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Fuels = {
	vec3(273.83,-1253.46,28.29),
	vec3(273.83,-1261.29,28.29),
	vec3(273.83,-1268.63,28.29),
	vec3(265.06,-1253.46,28.29),
	vec3(265.06,-1261.29,28.29),
	vec3(265.06,-1268.63,28.29),
	vec3(256.43,-1253.46,28.29),
	vec3(256.43,-1261.29,28.29),
	vec3(256.43,-1268.63,28.29),
	vec3(2680.90,3266.40,54.39),
	vec3(2678.51,3262.33,54.39),
	vec3(-2104.53,-311.01,12.16),
	vec3(-2105.39,-319.21,12.16),
	vec3(-2106.06,-325.57,12.16),
	vec3(-2097.48,-326.48,12.16),
	vec3(-2096.81,-320.11,12.16),
	vec3(-2096.09,-311.90,12.16),
	vec3(-2087.21,-312.81,12.16),
	vec3(-2088.08,-321.03,12.16),
	vec3(-2088.75,-327.39,12.16),
	vec3(-2551.39,2327.11,32.24),
	vec3(-2558.02,2326.70,32.24),
	vec3(-2558.48,2334.13,32.24),
	vec3(-2552.60,2334.46,32.24),
	vec3(-2558.77,2341.48,32.24),
	vec3(-2552.39,2341.89,32.24),
	vec3(186.97,6606.21,31.06),
	vec3(179.67,6604.93,31.06),
	vec3(172.33,6603.63,31.06),
	vec3(818.99,-1026.24,25.44),
	vec3(810.7,-1026.24,25.44),
	vec3(810.7,-1030.94,25.44),
	vec3(818.99,-1030.94,25.44),
	vec3(818.99,-1026.24,25.44),
	vec3(827.3,-1026.24,25.64),
	vec3(827.3,-1030.94,25.64),
	vec3(1207.07,-1398.16,34.39),
	vec3(1204.2,-1401.03,34.39),
	vec3(1210.07,-1406.9,34.39),
	vec3(1212.94,-1404.03,34.39),
	vec3(1178.97,-339.54,68.37),
	vec3(1186.4,-338.23,68.36),
	vec3(1184.89,-329.7,68.31),
	vec3(1177.46,-331.01,68.32),
	vec3(1175.71,-322.3,68.36),
	vec3(1183.13,-320.99,68.36),
	vec3(629.64,263.84,102.27),
	vec3(629.64,273.97,102.27),
	vec3(620.99,273.97,102.27),
	vec3(621.0,263.84,102.27),
	vec3(612.44,263.84,102.27),
	vec3(612.43,273.96,102.27),
	vec3(2588.41,358.56,107.66),
	vec3(2588.65,364.06,107.66),
	vec3(2581.18,364.39,107.66),
	vec3(2580.94,358.89,107.66),
	vec3(2573.55,359.21,107.66),
	vec3(2573.79,364.71,107.66),
	vec3(174.99,-1568.44,28.33),
	vec3(181.81,-1561.96,28.33),
	vec3(176.03,-1555.91,28.33),
	vec3(169.3,-1562.26,28.33),
	vec3(-329.81,-1471.63,29.73),
	vec3(-324.74,-1480.41,29.73),
	vec3(-317.26,-1476.09,29.73),
	vec3(-322.33,-1467.31,29.73),
	vec3(-314.92,-1463.03,29.73),
	vec3(-309.85,-1471.79,29.73),
	vec3(1786.08,3329.86,40.42),
	vec3(1785.04,3331.48,40.35),
	vec3(50.31,2778.54,57.05),
	vec3(48.92,2779.59,57.05),
	vec3(264.98,2607.18,43.99),
	vec3(263.09,2606.8,43.99),
	vec3(1035.45,2674.44,38.71),
	vec3(1043.22,2674.45,38.71),
	vec3(1043.22,2667.92,38.71),
	vec3(1035.45,2667.91,38.71),
	vec3(1209.59,2658.36,36.9),
	vec3(1208.52,2659.43,36.9),
	vec3(1205.91,2662.05,36.9),
	vec3(2539.8,2594.81,36.96),
	vec3(2001.55,3772.21,31.4),
	vec3(2003.92,3773.48,31.4),
	vec3(2006.21,3774.96,31.4),
	vec3(2009.26,3776.78,31.4),
	vec3(1684.6,4931.66,41.23),
	vec3(1690.1,4927.81,41.23),
	vec3(1705.74,6414.61,31.77),
	vec3(1701.73,6416.49,31.77),
	vec3(1697.76,6418.35,31.77),
	vec3(-97.06,6416.77,30.65),
	vec3(-91.29,6422.54,30.65),
	vec3(-1808.71,799.96,137.69),
	vec3(-1803.62,794.4,137.69),
	vec3(-1797.22,800.56,137.66),
	vec3(-1802.31,806.12,137.66),
	vec3(-1795.93,811.97,137.7),
	vec3(-1790.83,806.41,137.7),
	vec3(-1438.07,-268.69,45.41),
	vec3(-1444.5,-274.23,45.41),
	vec3(-1435.5,-284.68,45.41),
	vec3(-1429.07,-279.15,45.41),
	vec3(-732.64,-932.51,18.22),
	vec3(-732.64,-939.32,18.22),
	vec3(-724.0,-939.32,18.22),
	vec3(-724.0,-932.51,18.22),
	vec3(-715.43,-932.51,18.22),
	vec3(-715.43,-939.32,18.22),
	vec3(-532.28,-1212.71,17.33),
	vec3(-529.51,-1213.96,17.33),
	vec3(-524.92,-1216.15,17.33),
	vec3(-522.23,-1217.42,17.33),
	vec3(-518.52,-1209.5,17.33),
	vec3(-521.21,-1208.23,17.33),
	vec3(-525.8,-1206.04,17.33),
	vec3(-528.57,-1204.8,17.33),
	vec3(-72.03,-1765.1,28.53),
	vec3(-69.45,-1758.01,28.55),
	vec3(-77.59,-1755.05,28.81),
	vec3(-80.17,-1762.14,28.8),
	vec3(-63.61,-1767.93,28.27),
	vec3(-61.03,-1760.85,28.31)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	RegisterCommand("+entityTarget",TargetEnable)
	RegisterCommand("-entityTarget",TargetDisable)
	RegisterKeyMapping("+entityTarget","Interação auricular.","keyboard","LMENU")

	AddCircleZone("Trash:01",vec3(-330.36,-1564.11,25.47),0.25,{
		name = "Trash:01",
		heading = 0.0,
		useZ = true
	},{
		Distance = 1.25,
		shop = "Trasher",
		options = {
			{
				event = "inventory:Products",
				label = "Despejar Lixo",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("Trash:02",vec3(12.99,6501.61,31.84),0.25,{
		name = "Trash:02",
		heading = 0.0,
		useZ = true
	},{
		Distance = 1.25,
		shop = "Trasher",
		options = {
			{
				event = "inventory:Products",
				label = "Despejar Lixo",
				tunnel = "server"
			}
		}
	})

	AddTargetModel({ 654385216,161343630,-430989390,1096374064,-1519644200,-1932041857,207578973,-487222358 },{
		options = {
			{
				event = "slotmachine:Init",
				label = "Sentar",
				tunnel = "client"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ -832573324,-1430839454,1457690978,1682622302,402729631,-664053099,1794449327,307287994,-1323586730,111281960,-541762431,-745300483,-417505688 },{
		options = {
			{
				event = "inventory:Animals",
				label = "Esfolar",
				tunnel = "server"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ -206690185,666561306,218085040,-58485588,1511880420,682791951 },{
		options = {
			{
				event = "player:enterTrash",
				label = "Esconder",
				tunnel = "client"
			},{
				event = "player:checkTrash",
				label = "Verificar",
				tunnel = "server"
			},{
				event = "chest:Open",
				label = "Abrir",
				tunnel = "entity",
				service = "Trash"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ -1691644768,-742198632 },{
		options = {
			{
				event = "inventory:Drink",
				label = "Beber",
				tunnel = "server"
			},{
				event = "inventory:RefillGallon",
				label = "Encher Galão",
				tunnel = "server"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ 690372739 },{
		options = {
			{
				event = "shops:Open",
				label = "Abrir",
				tunnel = "products",
				service = "Coffee"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ -654402915,1421582485 },{
		options = {
			{
				event = "shops:Open",
				label = "Abrir",
				tunnel = "products",
				service = "Donut"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ 992069095,1114264700 },{
		options = {
			{
				event = "shops:Open",
				label = "Abrir",
				tunnel = "products",
				service = "Soda"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ 1129053052 },{
		options = {
			{
				event = "shops:Open",
				label = "Abrir",
				tunnel = "products",
				service = "Hamburger"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ -1581502570 },{
		options = {
			{
				event = "shops:Open",
				label = "Abrir",
				tunnel = "products",
				service = "Hotdog"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ 73774428 },{
		options = {
			{
				event = "shops:Open",
				label = "Abrir",
				tunnel = "products",
				service = "Cigarette"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ -272361894 },{
		options = {
			{
				event = "shops:Open",
				label = "Abrir",
				tunnel = "products",
				service = "Chihuahua"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ 1099892058 },{
		options = {
			{
				event = "shops:Open",
				label = "Abrir",
				tunnel = "products",
				service = "Water"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ -2007231801,1339433404,1694452750,1933174915,-462817101,-469694731,-164877493,486135101 },{
		options = {
			{
				event = "shops:Open",
				label = "Abrir",
				tunnel = "products",
				service = "Fuel"
			}
		},
		Distance = 1.25
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISABLEACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function DisableActions()
	if Focus then
		DisableControlAction(0,1,true)
		DisableControlAction(0,2,true)
	end

	for _,v in ipairs({ 18,55,76,22,23,24,25,75,140,141,142,143,243,257,263,311,102,179,203 }) do
		DisableControlAction(0,v,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGETENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function TargetEnable()
	local Ped = PlayerPedId()
	if LocalPlayer.state.Arena or LocalPlayer.state.Cancel or LocalPlayer.state.ItemCamera or LocalPlayer.state.Freecam or LocalPlayer.state.Carry or not LocalPlayer.state.Active or LocalPlayer.state.Buttons or LocalPlayer.state.Commands or LocalPlayer.state.Handcuff or IsPauseMenuActive() or exports["lb-phone"]:IsOpen() or not MumbleIsConnected() or Sucess or IsPedInAnyVehicle(Ped) then
		return false
	end

	Actived = true
	SendNUIMessage({ Action = "Open" })

	while Actived do
		DisableActions()

		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
		local HitCoords,Entitys,EntityHit = RayCastGamePlayCamera()

		for Index,v in pairs(Zones) do
			if #(Coords - Zones[Index].center) <= 5 then
				SetDrawOrigin(Zones[Index].center.x,Zones[Index].center.y,Zones[Index].center.z)
				DrawSprite("Textures","Normal",0.0,0.0,0.02,0.02 * GetAspectRatio(false),0.0,255,255,255,255)
				ClearDrawOrigin()
			end

			if Zones[Index]:isPointInside(HitCoords) and #(Coords - Zones[Index].center) <= v.targetoptions.Distance then
				if v.targetoptions.shop then
					Selected = v.targetoptions.shop
				end

				SendNUIMessage({ Action = "Valid", data = Zones[Index].targetoptions.options })

				Sucess = true
				while Sucess do
					SetDrawOrigin(Zones[Index].center.x,Zones[Index].center.y,Zones[Index].center.z)
					DrawSprite("Textures","Selected",0.0,0.0,0.02,0.02 * GetAspectRatio(false),0.0,255,255,255,255)
					ClearDrawOrigin()
					DisableActions()

					if IsDisabledControlJustReleased(1,24) then
						SetCursorLocation(0.5,0.5)
						SetNuiFocus(true,true)
						Focus = true
					end

					local Ped = PlayerPedId()
					local OtherCoords = RayCastGamePlayCamera()
					if not Zones[Index]:isPointInside(OtherCoords) or #(GetEntityCoords(Ped) - Zones[Index].center) > v.targetoptions.Distance then
						if Focus then
							SendNUIMessage({ Action = "Close" })
							SetNuiFocus(false,false)
							Actived = false
							Focus = false
						else
							SendNUIMessage({ Action = "Left" })
						end

						Sucess = false
					end

					Wait(1)
				end
			end
		end

		if EntityHit and GetEntityType(Entitys) ~= 0 then
			if LocalPlayer.state.Admin and IsControlJustPressed(1,38) then
				TriggerServerEvent("admin:Doords",GetEntityCoords(Entitys),GetEntityModel(Entitys),GetEntityHeading(Entitys))
			end

			local Menu = {}
			if IsEntityAVehicle(Entitys) and GetEntityHealth(Ped) > 100 and #(Coords - HitCoords) <= 1.0 then
				local Network = nil
				local Vehicle = GetLastDrivenVehicle()

				SetEntityAsMissionEntity(Entitys,true,true)
				if NetworkGetEntityIsNetworked(Entitys) then
					Network = NetworkGetNetworkIdFromEntity(Entitys)
				end

				Selected = { GetVehicleNumberPlateText(Entitys),GetEntityArchetypeName(Entitys),Entitys,Network,GetEntityModel(Entitys),false }

				for _,v in pairs(Fuels) do
					if #(Coords - v) <= 2.5 then
						table.insert(Menu,{ event = "engine:Supply", label = "Abastecer", tunnel = "client" })
						break
					end
				end

				if #Menu <= 0 then
					if GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_PETROLCAN") then
						Selected[6] = true
						table.insert(Menu,{ event = "engine:Supply", label = "Abastecer", tunnel = "client" })
					else
						if (TowedSouth:isPointInside(HitCoords) or TowedNorth:isPointInside(HitCoords)) and not Entity(Entitys).state.Tow then
							table.insert(Menu,{ event = "towed:Payment", label = "Entregar", tunnel = "paramedic" })
						else
							local Lockpick = Entity(Entitys).state.Lockpick
							if Lockpick then
								if GetVehicleDoorLockStatus(Entitys) <= 1 and GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_WRENCH") then
									for Index = 1,#Tyres do
										local BoneIndex = GetEntityBoneIndexByName(Entitys,Tyres[Index].Bone)
										local TyreCoords = GetWorldPositionOfEntityBone(Vehicle,BoneIndex)
										if #(Coords - TyreCoords) <= 1.0 then
											Selected[6] = Tyres[Index].Index
											table.insert(Menu,{ event = "inventory:RemoveTyres", label = "Retirar Pneu", tunnel = "server" })
										end
									end
								end

								if not IsPedArmed(Ped,7) and GetVehicleDoorLockStatus(Entitys) <= 1 then
									if VehicleWeight(Selected[2]) > 0 then
										table.insert(Menu,{ event = "trunkchest:openTrunk", label = "Abrir Porta-Malas", tunnel = "server" })
									end

									table.insert(Menu,{ event = "inventory:ChangePlate", label = "Trocar Placa", tunnel = "server" })

									if Lockpick and Lockpick == LocalPlayer.state.Passport then
										table.insert(Menu,{ event = "garages:Key", label = "Chave Veícular", tunnel = "server" })
									end
								end

								table.insert(Menu,{ event = "engine:Vehrify", label = "Verificar", tunnel = "client" })
							else
								if GetEntityBoneIndexByName(Entitys,"boot") ~= -1 and IsVehicleSeatFree(Entitys,-1) and GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_CROWBAR") then
									table.insert(Menu,{ event = "inventory:StealTrunk", label = "Arrombar Porta-Malas", tunnel = "server" })
								end

								if Selected[2] == "stockade" then
									table.insert(Menu,{ event = "inventory:Stockade", label = "Vasculhar", tunnel = "server" })
								end
							end

							if not IsThisModelABike(Selected[5]) then
								local Rolling = GetEntityRoll(Entitys)
								if Rolling > 75.0 or Rolling < -75.0 then
									table.insert(Menu,{ event = "player:RollVehicle", label = "Desvirar", tunnel = "server" })
								end

								if GetEntityBoneIndexByName(Entitys,"boot") ~= -1 and not IsPedArmed(Ped,7) and GetVehicleDoorLockStatus(Entitys) <= 1 then
									table.insert(Menu,{ event = "player:checkTrunk", label = "Checar Porta-Malas", tunnel = "server" })
									table.insert(Menu,{ event = "player:enterTrunk", label = "Entrar no Porta-Malas", tunnel = "client" })
								end
							end

							if GetEntityArchetypeName(Vehicle) == "flatbed" and Selected[2] ~= "flatbed" then
								table.insert(Menu,{ event = "inventory:Tow", label = "Rebocar", tunnel = "client" })
							end

							if CheckPolice() then
								table.insert(Menu,{ event = "towed:Impound", label = "Impound", tunnel = "server" })

								if GetResourceState("mdt") == "started" then
									table.insert(Menu,{ event = "mdt:Vehicle", label = "Apreender", tunnel = "server" })
								else
									table.insert(Menu,{ event = "prison:Vehicle", label = "Apreender", tunnel = "server" })
								end
							else
								for _,v in pairs(Dismantle) do
									if #(Coords - v) <= 15 then
										table.insert(Menu,{ event = "inventory:Dismantle", label = "Desmanchar", tunnel = "server" })
										break
									end
								end
							end
						end
					end
				end

				if #Menu >= 1 then
					SendNUIMessage({ Action = "Valid", data = Menu })

					Sucess = true
					while Sucess do
						DisableActions()

						if IsDisabledControlJustReleased(1,24) then
							SetCursorLocation(0.5,0.5)
							SetNuiFocus(true,true)
							Focus = true
						end

						local Ped = PlayerPedId()
						local OtherCoords,OtherEntity = RayCastGamePlayCamera()
						if GetEntityType(OtherEntity) == 0 or #(GetEntityCoords(Ped) - OtherCoords) > 2.0 then
							if Focus then
								SendNUIMessage({ Action = "Close" })
								SetNuiFocus(false,false)
								Actived = false
								Focus = false
							else
								SendNUIMessage({ Action = "Left" })
							end

							Sucess = false
						end

						Wait(1)
					end
				end
			elseif IsPedAPlayer(Entitys) and GetEntityHealth(Ped) > 100 and #(Coords - HitCoords) <= 2.0 then
				local Index = NetworkGetPlayerIndexFromPed(Entitys)
				local source = GetPlayerServerId(Index)

				Selected = { source }

				table.insert(Menu,{ event = "inspect:Player", label = "Revistar", tunnel = "paramedic" })
				table.insert(Menu,{ event = "paramedic:Diagnostic", label = "Informações", tunnel = "paramedic" })

				if GetEntityHealth(Entitys) <= 100 then
					if Player(source).state.Crawl then
						table.insert(Menu,{ event = "paramedic:Adrenaline", label = "Ajudar", tunnel = "paramedic" })
					end

					if LocalPlayer.state.Paramedico then
						table.insert(Menu,{ event = "paramedic:Revive", label = "Reanimar", tunnel = "paramedic" })
					end
				else
					table.insert(Menu,{ event = "player:Demand", label = "Cobrança", tunnel = "paramedic" })

					if IsEntityPlayingAnim(Entitys,"random@mugging3","handsup_standing_base",3) then
						table.insert(Menu,{ event = "player:checkShoes", label = "Roubar Sapatos", tunnel = "paramedic" })
					end

					if LocalPlayer.state.Paramedico then
						table.insert(Menu,{ event = "paramedic:Treatment", label = "Tratamento", tunnel = "paramedic" })
						table.insert(Menu,{ event = "paramedic:Bandage", label = "Passar Ataduras", tunnel = "paramedic" })
						table.insert(Menu,{ event = "paramedic:presetBurn", label = "Roupa de Queimadura", tunnel = "paramedic" })
						table.insert(Menu,{ event = "paramedic:presetPlaster", label = "Colocar Gesso", tunnel = "paramedic" })
						table.insert(Menu,{ event = "paramedic:extractBlood", label = "Extrair Sangue", tunnel = "paramedic" })
						table.insert(Menu,{ event = "target:Repose", label = "Repouso", tunnel = "paramedic" })
					end
				end

				if CheckPolice() then
					table.insert(Menu,{ event = "prison:Itens", label = "Apreender", tunnel = "paramedic" })
				end

				if #Menu >= 1 then
					SendNUIMessage({ Action = "Valid", data = Menu })

					Sucess = true
					while Sucess do
						DisableActions()

						if IsDisabledControlJustReleased(1,24) then
							SetCursorLocation(0.5,0.5)
							SetNuiFocus(true,true)
							Focus = true
						end

						local Ped = PlayerPedId()
						local OtherCoords,OtherEntity = RayCastGamePlayCamera()
						if GetEntityType(OtherEntity) == 0 or #(GetEntityCoords(Ped) - OtherCoords) > 2.0 then
							if Focus then
								SendNUIMessage({ Action = "Close" })
								SetNuiFocus(false,false)
								Actived = false
								Focus = false
							else
								SendNUIMessage({ Action = "Left" })
							end

							Sucess = false
						end

						Wait(1)
					end
				end
			elseif IsEntityAPed(Entitys) and not DecorGetBool(Entitys,"CREATIVE_PED") and not IsPedAPlayer(Entitys) and #(Coords - HitCoords) <= 2.0 then
				Selected = { NetworkGetNetworkIdFromEntity(Entitys) }

				if LocalPlayer.state.Admin then
					table.insert(Menu,{ event = "DeletePed", label = "Deletar", tunnel = "paramedic" })
				end

				if #Menu >= 1 then
					SendNUIMessage({ Action = "Valid", data = Menu })

					Sucess = true
					while Sucess do
						DisableActions()

						if IsDisabledControlJustReleased(1,24) then
							SetCursorLocation(0.5,0.5)
							SetNuiFocus(true,true)
							Focus = true
						end

						local Ped = PlayerPedId()
						local OtherCoords,OtherEntity = RayCastGamePlayCamera()
						if GetEntityType(OtherEntity) == 0 or #(GetEntityCoords(Ped) - OtherCoords) > 2.0 then
							if Focus then
								SendNUIMessage({ Action = "Close" })
								SetNuiFocus(false,false)
								Actived = false
								Focus = false
							else
								SendNUIMessage({ Action = "Left" })
							end

							Sucess = false
						end

						Wait(1)
					end
				end
			else
				for Index in pairs(Models) do
					if DoesEntityExist(Entitys) and Index == GetEntityModel(Entitys) then
						local OtherCoords = GetEntityCoords(Entitys)
						if #(Coords - OtherCoords) <= 5 then
							SetDrawOrigin(OtherCoords.x,OtherCoords.y,OtherCoords.z + 1)
							DrawSprite("Textures","Normal",0.0,0.0,0.02,0.02 * GetAspectRatio(false),0.0,255,255,255,255)
							ClearDrawOrigin()
						end

						if #(Coords - HitCoords) <= Models[Index].Distance then
							if not IsEntityAMissionEntity(Entitys) then
								SetEntityAsMissionEntity(Entitys,true,true)
							end

							local Network = nil
							if NetworkGetEntityIsNetworked(Entitys) then
								Network = NetworkGetNetworkIdFromEntity(Entitys)
							end

							Selected = { Entitys,Index,Network,GetEntityCoords(Entitys),IsEntityDead(Entitys) }

							SendNUIMessage({ Action = "Valid", data = Models[Index].options })

							Sucess = true
							while Sucess do
								local EntityCoords = GetEntityCoords(Entitys)

								SetDrawOrigin(EntityCoords.x,EntityCoords.y,EntityCoords.z + 1)
								DrawSprite("Textures","Selected",0.0,0.0,0.02,0.02 * GetAspectRatio(false),0.0,255,255,255,255)
								ClearDrawOrigin()
								DisableActions()

								if IsDisabledControlJustReleased(1,24) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
									Focus = true
								end

								local Ped = PlayerPedId()
								local OtherCoords,OtherEntity = RayCastGamePlayCamera()
								if GetEntityType(OtherEntity) == 0 or #(GetEntityCoords(Ped) - OtherCoords) > 2.0 then
									if Focus then
										SendNUIMessage({ Action = "Close" })
										SetNuiFocus(false,false)
										Actived = false
										Focus = false
									else
										SendNUIMessage({ Action = "Left" })
									end

									Sucess = false
								end

								Wait(1)
							end
						end
					end
				end
			end
		end

		Wait(1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ROLLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:RollVehicle")
AddEventHandler("target:RollVehicle",function(Network)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			SetVehicleOnGroundProperly(Vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGETDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function TargetDisable()
	if Focus or not Actived then
		return false
	end

	TriggerEvent("target:Debug")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Select",function(Data,Callback)
	TriggerEvent("target:Debug")

	if not LocalPlayer.state.Cancel then
		if Data.tunnel == "client" then
			TriggerEvent(Data.event,Selected,Data.service)
		elseif Data.tunnel == "entity" then
			TriggerEvent(Data.event,Selected[1],Data.service)
		elseif Data.tunnel == "products" then
			TriggerEvent(Data.event,Data.service)
		elseif Data.tunnel == "server" then
			TriggerServerEvent(Data.event,Selected,Data.service)
		elseif Data.tunnel == "paramedic" then
			TriggerServerEvent(Data.event,Selected[1],Data.service)
		elseif Data.tunnel == "proserver" then
			TriggerServerEvent(Data.event,Data.service)
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	TriggerEvent("target:Debug")

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Debug")
AddEventHandler("target:Debug",function()
	Focus = false
	Sucess = false
	Actived = false
	SetNuiFocus(false,false)
	SendNUIMessage({ Action = "Close" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(Distance,Coords)
	local Rotation = GetGameplayCamRot()
	local Adjuste = vec3((math.pi / 180) * Rotation.x,(math.pi / 180) * Rotation.y,(math.pi / 180) * Rotation.z)
	local Direction = vec3(-math.sin(Adjuste[3]) * math.abs(math.cos(Adjuste[1])),math.cos(Adjuste[3]) * math.abs(math.cos(Adjuste[1])),math.sin(Adjuste[1]))

	return vec3(Coords[1] + Direction[1] * Distance, Coords[2] + Direction[2] * Distance, Coords[3] + Direction[3] * Distance)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAYCASTGAMEPLAYCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function RayCastGamePlayCamera()
	local Ped = PlayerPedId()
	local Cam = GetGameplayCamCoord()
	local Cam2 = GetCoordsFromCam(10.0,Cam)
	local Handle = StartExpensiveSynchronousShapeTestLosProbe(Cam,Cam2,-1,Ped,4)
	local Hit,__,Coords,_,Entitys = GetShapeTestResult(Handle)

	return Coords,Entitys,Hit
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddCircleZone(Name,Center,Radius,Options,Target)
	Zones[Name] = CircleZone:Create(Center,Radius,Options)
	Zones[Name].targetoptions = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function RemCircleZone(Name)
	if Zones[Name] then
		Zones[Name]:destroy()
		Zones[Name] = nil
	end

	if Sucess then
		TriggerEvent("target:Debug")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTARGETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function AddTargetModel(Model,Options)
	for _,v in pairs(Model) do
		Models[v] = Options
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function LabelText(Name,Text)
	if Zones[Name] then
		Zones[Name].targetoptions.options[1].label = Text
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function LabelOptions(Name,Text)
	if Zones[Name] then
		Zones[Name].targetoptions.options = Text
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBOXZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddBoxZone(Name,Center,Length,Width,Options,Target)
	Zones[Name] = BoxZone:Create(Center,Length,Width,Options)
	Zones[Name].targetoptions = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("LabelText",LabelText)
exports("AddBoxZone",AddBoxZone)
exports("LabelOptions",LabelOptions)
exports("RemCircleZone",RemCircleZone)
exports("AddCircleZone",AddCircleZone)
exports("AddTargetModel",AddTargetModel)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Weapon = ""
local Skins = {}
local Objects = {}
TakeWeapon = false
StoreWeapon = false
local Reload = GetGameTimer()
local Cooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SKINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Skins")
AddEventHandler("inventory:Skins",function(Table)
	Skins = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Config = {
	["WEAPON_KATANA"] = {
		["Bone"] = 24818,
		["x"] = 0.27,
		["y"] = -0.15,
		["z"] = 0.22,
		["RotX"] = 0.0,
		["RotY"] = 220.0,
		["RotZ"] = 2.5,
		["Model"] = "w_me_katana"
	},
	["WEAPON_CARBINERIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_carbinerifle"
	},
	["WEAPON_M4A4"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_m4a4"
	},
	["WEAPON_CARBINERIFLE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_carbineriflemk2"
	},
	["WEAPON_ADVANCEDRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.14,
		["z"] = -0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_advancedrifle"
	},
	["WEAPON_BULLPUPRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.14,
		["z"] = -0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_bullpuprifle"
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.14,
		["z"] = -0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_bullpupriflemk2"
	},
	["WEAPON_SPECIALCARBINE"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_specialcarbine"
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_specialcarbinemk2"
	},
	["WEAPON_MUSKET"] = {
		["Bone"] = 24818,
		["x"] = -0.1,
		["y"] = -0.14,
		["z"] = 0.0,
		["RotX"] = 0.0,
		["RotY"] = 0.8,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_musket"
	},
	["WEAPON_BAT"] = {
		["Bone"] = 24818,
		["x"] = -0.18,
		["y"] = -0.18,
		["z"] = 0.0,
		["RotX"] = 0.0,
		["RotY"] = 90.0,
		["RotZ"] = 2.5,
		["Model"] = "w_me_bat"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sg_pumpshotgun"
	},
	["WEAPON_RPG"] = {
		["Bone"] = 24818,
		["x"] = -0.20,
		["y"] = -0.22,
		["z"] = 0.0,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,2.5,
		["Model"] = "w_lr_rpg"
	},
	["WEAPON_PUMPSHOTGUN_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sg_pumpshotgunmk2"
	},
	["WEAPON_SMG"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sb_smg"
	},
	["WEAPON_SMG_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.22,
		["y"] = -0.14,
		["z"] = 0.12,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sb_smgmk2"
	},
	["WEAPON_COMPACTRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.22,
		["y"] = -0.14,
		["z"] = 0.12,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_assaultrifle_smg"
	},
	["WEAPON_ASSAULTSMG"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.07,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sb_assaultsmg"
	},
	["WEAPON_HEAVYRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_heavyrifleh"
	},
	["WEAPON_TACTICALRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_carbinerifle_reh"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_assaultrifle"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_assaultrifle"
	},
	["WEAPON_GUSENBERG"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sb_gusenberg"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RemoveWeapon")
AddEventHandler("inventory:RemoveWeapon",function(Name)
	local Name = SplitOne(Name)

	if Objects[Name] then
		TriggerServerEvent("DeleteObject",0,Name)
		Objects[Name] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CREATEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:CreateWeapon")
AddEventHandler("inventory:CreateWeapon",function(Name)
	local WeaponName = SplitOne(Name)
	if not Config[WeaponName] or Objects[WeaponName] then
		return false
	end

	local WeaponModel = nil
	local Ped = PlayerPedId()
	local Data = Config[WeaponName]
	local Coords = GetEntityCoords(Ped)
	local Bone = GetPedBoneIndex(Ped,Data.Bone)

	if Skins[WeaponName] then
		local Hash = GetHashKey(Skins[WeaponName])
		WeaponModel = GetWeaponComponentTypeModel(Hash)
	end

	local Networked = vRPS.CreateObject(Data.Model,Coords.x,Coords.y,Coords.z,WeaponName,WeaponModel)
	if not Networked then
		return false
	end

	Objects[WeaponName] = LoadNetwork(Networked)
	while not DoesEntityExist(Objects[WeaponName]) do
		Wait(100)
	end

	SetEntityCollision(Objects[WeaponName],false,false)
	SetEntityCompletelyDisableCollision(Objects[WeaponName],false,true)
	AttachEntityToEntity(Objects[WeaponName],Ped,Bone,Data.x,Data.y,Data.z,Data.RotX,Data.RotY,Data.RotZ,true,true,false,false,2,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	LoadAnim("rcmjosh4")
	LoadAnim("weapons@pistol@")

	while true do
		local TimeDistance = 999
		if Weapon ~= "" and Actived then
			TimeDistance = 100

			local Ped = PlayerPedId()
			local CurrentTimer = GetGameTimer()
			local Ammo = GetAmmoInPedWeapon(Ped,Weapon)
			if IsPedReloading(Ped) and CurrentTimer >= Reload then
				vSERVER.PreventWeapons(Weapon,Ammo)
				Reload = CurrentTimer + 1000
			end

			local NoAmmo = Ammo <= 0
			local LowPetrol = Weapon == "WEAPON_PETROLCAN" and Ammo <= 135 and IsPedShooting(Ped)
			if (NoAmmo or LowPetrol) and CurrentTimer >= Cooldown then
				if Types ~= "" then
					vSERVER.RemoveThrowing(Types)
				else
					vSERVER.PreventWeapons(Weapon,Ammo)
				end

				TriggerEvent("inventory:CleanWeapons")
				Cooldown = CurrentTimer + 1000
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:verifyWeapon")
AddEventHandler("inventory:verifyWeapon",function(Item)
	local Name = SplitOne(Item)

	if Weapon ~= "" then
		local Ped = PlayerPedId()
		local AmmoItem = WeaponAmmo(Item)
		local AmmoHand = WeaponAmmo(Weapon)

		if AmmoItem and AmmoHand then
			local DoesWeapon = Weapon == Name
			local Ammo = GetAmmoInPedWeapon(Ped,DoesWeapon and Weapon or Name)

			if DoesWeapon then
				if not vSERVER.VerifyWeapon(Weapon,Ammo) then
					TriggerEvent("inventory:CleanWeapons")
				end
			elseif AmmoItem ~= AmmoHand then
				if not vSERVER.VerifyWeapon(Name,Ammo) then
					TriggerEvent("inventory:CleanWeapons")
				end
			else
				TriggerEvent("inventory:RemoveWeapon",Item)
			end
		end
	else
		vSERVER.VerifyWeapon(Name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:CleanWeapons",function(Ignore)
	if Weapon ~= "" then
		local Ped = PlayerPedId()

		if not Ignore then
			local Ammo = GetAmmoInPedWeapon(Ped,Weapon)
			if vSERVER.PreventWeapons(Weapon,Ammo) then
				TriggerEvent("inventory:CreateWeapon",Weapon)
			end
		end

		TriggerEvent("Weapon","")
		TriggerEvent("hud:Weapon",false)
		RemoveAllPedWeapons(Ped,true)

		Actived = false
		Weapon = ""
		Types = ""
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ReturnWeapon()
	return Weapon ~= "" and Weapon or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckWeapon(Hash)
	return Weapon == Hash and true or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVECOMPONENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.GiveComponent(Component)
	GiveWeaponComponentToPed(PlayerPedId(),Weapon,Component)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.TakeWeapon(Name,Ammo,Components,Type,Skin)
	if not TakeWeapon then
		if not Ammo then
			Ammo = 0
		end

		if Ammo > 0 then
			Actived = true
		end

		TakeWeapon = true
		LocalPlayer["state"]:set("Cancel",true,true)

		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			TaskPlayAnim(Ped,"rcmjosh4","josh_leadout_cop2",8.0,8.0,-1,48,1,0,0,0)

			Wait(200)

			Weapon = Name
			TriggerEvent("Weapon",Weapon)
			TriggerEvent("inventory:RemoveWeapon",Weapon)
			GiveWeaponToPed(Ped,Weapon,Ammo,false,true)

			if Skin then
				GiveWeaponComponentToPed(Ped,Weapon,Skin)
			end

			if Components then
				for Item,_ in pairs(Components) do
					local Comp = WeaponAttach(SplitOne(Item),Weapon)
					GiveWeaponComponentToPed(Ped,Weapon,Comp)
				end
			end

			Wait(300)

			ClearPedTasks(Ped)

			SetTimeout(2500,function()
				if Weapon ~= "" and GetSelectedPedWeapon(Ped) ~= GetHashKey(Weapon) then
					TriggerEvent("inventory:CleanWeapons")
				end
			end)
		else
			Weapon = Name
			TriggerEvent("Weapon",Weapon)
			TriggerEvent("inventory:RemoveWeapon",Weapon)
			GiveWeaponToPed(Ped,Weapon,Ammo,false,true)

			if Skin then
				GiveWeaponComponentToPed(Ped,Weapon,Skin)
			end

			if Components then
				for Item,_ in pairs(Components) do
					local Comp = WeaponAttach(SplitOne(Item),Weapon)
					GiveWeaponComponentToPed(Ped,Weapon,Comp)
				end
			end
		end

		if Type then
			Types = Type
		end

		TakeWeapon = false
		LocalPlayer["state"]:set("Cancel",false,true)

		if WeaponAmmo(Weapon) then
			TriggerEvent("hud:Weapon",true,Weapon)
		end

		if (IsPedInAnyVehicle(Ped) and not ItemVehicle(Weapon)) or vSERVER.CheckExistWeapons(Weapon) then
			TriggerEvent("inventory:CleanWeapons")
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StoreWeapon()
	if not StoreWeapon and Weapon ~= "" then
		StoreWeapon = true

		local Lasted = Weapon
		local Ped = PlayerPedId()
		local Ammo = GetAmmoInPedWeapon(Ped,Weapon)
		LocalPlayer["state"]:set("Cancel",true,true)

		if not IsPedInAnyVehicle(Ped) then
			TaskPlayAnim(Ped,"weapons@pistol@","aim_2_holster",8.0,8.0,-1,48,1,0,0,0)

			Wait(450)

			ClearPedTasks(Ped)
		end

		StoreWeapon = false
		TriggerEvent("inventory:CleanWeapons")
		LocalPlayer["state"]:set("Cancel",false,true)

		return true,Ammo,Lasted
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFOWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.InfoWeapon(Type)
	local Ammo = 0

	if Weapon ~= "" then
		Ammo = GetAmmoInPedWeapon(PlayerPedId(),Weapon)
	end

	return Weapon,Ammo
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELOADING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Reloading(Hash,Ammo)
	AddAmmoToPed(PlayerPedId(),Hash,Ammo)
	Actived = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Parachute()
	GiveWeaponToPed(PlayerPedId(),"GADGET_PARACHUTE",1,false,true)
end
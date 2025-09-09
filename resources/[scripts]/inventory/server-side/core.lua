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
Tunnel.bindInterface("inventory",Creative)
vDEVICE = Tunnel.getInterface("device")
vFARMER = Tunnel.getInterface("farmer")
vPLAYER = Tunnel.getInterface("player")
vGARAGE = Tunnel.getInterface("garages")
vCLIENT = Tunnel.getInterface("inventory")
vSURVIVAL = Tunnel.getInterface("survival")
vKEYBOARD = Tunnel.getInterface("keyboard")
vPARAMEDIC = Tunnel.getInterface("paramedic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Arena = {}
Drugs = {}
Drops = {}
Carry = {}
Active = {}
Plates = {}
Trunks = {}
Objects = {}
Robberys = {}
SaveObjects = {}
local Payments = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERS
-----------------------------------------------------------------------------------------------------------------------------------------
Users = {
	["Ammos"] = {},
	["Attachs"] = {},
	["Blueprints"] = {},
	["Skins"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
Buffs = {
	["Dexterity"] = {},
	["Luck"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
Products = {
	["Trasher"] = {
		["Timer"] = 5,
		["Item"] = "binbag",
		["Itens"] = {
			{ ["Item"] = "plastic", ["Chance"] = 100, ["Min"] = 6, ["Max"] = 10 },
			{ ["Item"] = "glass", ["Chance"] = 100, ["Min"] = 6, ["Max"] = 10 },
			{ ["Item"] = "rubber", ["Chance"] = 100, ["Min"] = 6, ["Max"] = 10 },
			{ ["Item"] = "aluminum", ["Chance"] = 50, ["Min"] = 4, ["Max"] = 8 },
			{ ["Item"] = "copper", ["Chance"] = 50, ["Min"] = 4, ["Max"] = 8 },
			{ ["Item"] = "techtrash", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "tarp", ["Chance"] = 7, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "sheetmetal", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "roadsigns", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "scotchtape", ["Chance"] = 3, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "insulatingtape", ["Chance"] = 3, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "electroniccomponents", ["Chance"] = 3, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "batteryaa", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "batteryaaplus", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "emptybottle", ["Chance"] = 25, ["Min"] = 3, ["Max"] = 4 }
		}
	},
	["Cemitery"] = {
		["Timer"] = 10,
		["Police"] = true,
		["Animation"] = {
			["Dict"] = "amb@medic@standing@tendtodead@idle_a",
			["Anim"] = "idle_a"
		},
		["Itens"] = {
			{ ["Item"] = "joint", ["Chance"] = 25, ["Min"] = 2, ["Max"] = 3 },
			{ ["Item"] = "cocaine", ["Chance"] = 25, ["Min"] = 2, ["Max"] = 3 },
			{ ["Item"] = "meth", ["Chance"] = 25, ["Min"] = 2, ["Max"] = 3 },
			{ ["Item"] = "alliance", ["Chance"] = 50, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "scotchtape", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "insulatingtape", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "screws", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 3 },
			{ ["Item"] = "screwnuts", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 3 },
			{ ["Item"] = "goldnecklace", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "silverchain", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "horsefigurine", ["Chance"] = 3, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "toothpaste", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "treasurebox", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "suitcase", ["Chance"] = 35, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "gauze", ["Chance"] = 45, ["Min"] = 2, ["Max"] = 3 },
			{ ["Item"] = "lockpick", ["Chance"] = 35, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "cellphone", ["Chance"] = 45, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "cigarette", ["Chance"] = 75, ["Min"] = 4, ["Max"] = 6 },
			{ ["Item"] = "lighter", ["Chance"] = 45, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "vape", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "pager", ["Chance"] = 2, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "scotchtape", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "insulatingtape", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "screws", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "screwnuts", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 }
		},
		["Residual"] = "Resíduo de Clorofórmio"
	},
	["Milkman"] = {
		["Timer"] = 5,
		["PolyZone"] = true,
		["Item"] = "emptybottle",
		["Animation"] = {
			["Dict"] = "amb@medic@standing@kneel@base",
			["Anim"] = "base"
		},
		["Itens"] = {
			{ ["Item"] = "milkbottle", ["Chance"] = 100, ["Min"] = 1, ["Max"] = 1 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOTS
-----------------------------------------------------------------------------------------------------------------------------------------
Loots = {
	["LootMedics"] = {
		["Players"] = {},
		["Cooldown"] = 3600,
		["Item"] = "medicalkey",
		["List"] = {
			{ ["Item"] = "joint", ["Chance"] = 65, ["Min"] = 2, ["Max"] = 3 },
			{ ["Item"] = "cocaine", ["Chance"] = 65, ["Min"] = 2, ["Max"] = 3 },
			{ ["Item"] = "meth", ["Chance"] = 65, ["Min"] = 2, ["Max"] = 3 },
			{ ["Item"] = "crack", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "heroin", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "metadone", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "codeine", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "amphetamine", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "sulfuric", ["Chance"] = 45, ["Min"] = 2, ["Max"] = 3 },
			{ ["Item"] = "acetone", ["Chance"] = 45, ["Min"] = 2, ["Max"] = 3 },
			{ ["Item"] = "saline", ["Chance"] = 45, ["Min"] = 2, ["Max"] = 3 },
			{ ["Item"] = "alcohol", ["Chance"] = 45, ["Min"] = 2, ["Max"] = 3 },
			{ ["Item"] = "syringe01", ["Chance"] = 65, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "syringe02", ["Chance"] = 65, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "syringe03", ["Chance"] = 65, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "syringe04", ["Chance"] = 65, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "bandage", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "medkit", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "ritmoneury", ["Chance"] = 35, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "sinkalmy", ["Chance"] = 35, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "analgesic", ["Chance"] = 35, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "gauze", ["Chance"] = 45, ["Min"] = 2, ["Max"] = 4 },
			{ ["Item"] = "adrenaline", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_rubber", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_saline", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_acetone", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_alcohol", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_gauze", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_medkit", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_analgesic", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_sinkalmy", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_bandage", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ritmoneury", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_sulfuric", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 }
		}
	},
	["LootWeapons"] = {
		["Players"] = {},
		["Cooldown"] = 7200,
		["Item"] = "weaponkey",
		["List"] = {
			{ ["Item"] = "repairkit01", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "repairkit02", ["Chance"] = 10, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "repairkit03", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "repairkit04", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "nitro", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "circuit", ["Chance"] = 35, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "gunpowder", ["Chance"] = 65, ["Min"] = 1, ["Max"] = 3 },
			{ ["Item"] = "pistolbody", ["Chance"] = 50, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "smgbody", ["Chance"] = 35, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "riflebody", ["Chance"] = 20, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "techtrash", ["Chance"] = 50, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "explosives", ["Chance"] = 50, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "safependrive", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "weaponparts", ["Chance"] = 15, ["Min"] = 2, ["Max"] = 3 },
			{ ["Item"] = "dismantle", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blocksignal", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "ballisticplate", ["Chance"] = 10, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "lockpick", ["Chance"] = 50, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "handcuff", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "hood", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ATTACH_GRIP", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_PISTOL_AMMO", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_MUSKET", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ATTACH_MAGAZINE", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_weaponparts", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_MUSKET_AMMO", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_smgbody", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_HEAVYPISTOL", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ATTACH_FLASHLIGHT", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_riflebody", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_PISTOL", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SNSPISTOL_MK2", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ATTACH_SILENCER", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_PISTOL50", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_STUNGUN", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SNSPISTOL", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_gunpowder", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_pistolbody", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ATTACH_CROSSHAIR", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_PISTOL_MK2", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SMOKEGRENADE", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_MOLOTOV", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SHOTGUN_AMMO", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_RIFLE_AMMO", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SMG_AMMO", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_COMBATPISTOL", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_VINTAGEPISTOL", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 }
		}
	},
	["LootSupplies"] = {
		["Players"] = {},
		["Cooldown"] = 3600,
		["Item"] = "utilkey",
		["List"] = {
			{ ["Item"] = "weedclone", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "cokeclone", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "plate", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "plastic", ["Chance"] = 100, ["Min"] = 6, ["Max"] = 10 },
			{ ["Item"] = "glass", ["Chance"] = 100, ["Min"] = 6, ["Max"] = 10 },
			{ ["Item"] = "rubber", ["Chance"] = 100, ["Min"] = 6, ["Max"] = 10 },
			{ ["Item"] = "aluminum", ["Chance"] = 75, ["Min"] = 4, ["Max"] = 8 },
			{ ["Item"] = "copper", ["Chance"] = 75, ["Min"] = 4, ["Max"] = 8 },
			{ ["Item"] = "techtrash", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "tarp", ["Chance"] = 35, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "sheetmetal", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "roadsigns", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "explosives", ["Chance"] = 45, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "scotchtape", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "insulatingtape", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "screws", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "screwnuts", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "bait", ["Chance"] = 75, ["Min"] = 5, ["Max"] = 10 },
			{ ["Item"] = "sapphire_pure", ["Chance"] = 50, ["Min"] = 3, ["Max"] = 6 },
			{ ["Item"] = "emerald_pure", ["Chance"] = 50, ["Min"] = 3, ["Max"] = 6 },
			{ ["Item"] = "ruby_pure", ["Chance"] = 50, ["Min"] = 3, ["Max"] = 6 },
			{ ["Item"] = "gold_pure", ["Chance"] = 50, ["Min"] = 3, ["Max"] = 6 },
			{ ["Item"] = "iron_pure", ["Chance"] = 50, ["Min"] = 3, ["Max"] = 6 },
			{ ["Item"] = "lead_pure", ["Chance"] = 50, ["Min"] = 3, ["Max"] = 6 },
			{ ["Item"] = "tin_pure", ["Chance"] = 50, ["Min"] = 3, ["Max"] = 6 },
			{ ["Item"] = "diamond_pure", ["Chance"] = 50, ["Min"] = 3, ["Max"] = 6 },
			{ ["Item"] = "copper_pure", ["Chance"] = 50, ["Min"] = 3, ["Max"] = 6 },
			{ ["Item"] = "binoculars", ["Chance"] = 35, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "camera", ["Chance"] = 35, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "postit", ["Chance"] = 65, ["Min"] = 4, ["Max"] = 6 },
			{ ["Item"] = "radio", ["Chance"] = 35, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "cigarette", ["Chance"] = 75, ["Min"] = 3, ["Max"] = 6 },
			{ ["Item"] = "lighter", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "soap", ["Chance"] = 35, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "emptybottle", ["Chance"] = 75, ["Min"] = 3, ["Max"] = 4 },
			{ ["Item"] = "blueprint_batteryaaplus", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_rubber", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_silverchain", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_glass", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_electroniccomponents", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_toothpaste", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_videocard", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_screws", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_roadsigns", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_processorfan", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_rammemory", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_copper", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_powercable", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_batteryaa", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_processor", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_insulatingtape", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_safependrive", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_aluminum", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_plastic", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_techtrash", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_scotchtape", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_screwnuts", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_sheetmetal", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_powersupply", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ssddrive", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_goldnecklace", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_tarp", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_circuit", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_horsefigurine", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_explosives", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 }
		}
	},
	["LootLegendary"] = {
		["Players"] = {},
		["Cooldown"] = 10800,
		["Item"] = "legendarykey",
		["List"] = {
			{ ["Item"] = "blueprint_WEAPON_ADVANCEDRIFLE", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_COMPACTRIFLE", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_batteryaaplus", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_rubber", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_silverchain", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ATTACH_GRIP", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SAWNOFFSHOTGUN", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_saline", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_glass", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_MICROSMG", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_HEAVYRIFLE", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_PISTOL_AMMO", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_acetone", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_ASSAULTRIFLE", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_alcohol", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_electroniccomponents", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_gauze", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_MUSKET", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_BULLPUPRIFLE", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_toothpaste", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ATTACH_MAGAZINE", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_videocard", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_screws", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_ASSAULTRIFLE_MK2", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_roadsigns", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_processorfan", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_rammemory", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_weaponparts", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_MUSKET_AMMO", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_copper", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_smgbody", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_HEAVYPISTOL", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_medkit", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_powercable", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_batteryaa", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_CARBINERIFLE_MK2", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ATTACH_FLASHLIGHT", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_processor", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_insulatingtape", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_safependrive", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_riflebody", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_PISTOL", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_aluminum", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SNSPISTOL_MK2", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ATTACH_SILENCER", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SPECIALCARBINE_MK2", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_plastic", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_PISTOL50", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_MINISMG", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_TACTICALRIFLE", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_techtrash", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_scotchtape", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_STUNGUN", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_screwnuts", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SNSPISTOL", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_analgesic", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_sinkalmy", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_gunpowder", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_bandage", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_GUSENBERG", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_ASSAULTSMG", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SMG_MK2", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_pistolbody", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_sheetmetal", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SMG", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_powersupply", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_PUMPSHOTGUN_MK2", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_PUMPSHOTGUN", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SPECIALCARBINE", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_BULLPUPRIFLE_MK2", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_CARBINERIFLE", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ATTACH_CROSSHAIR", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_MACHINEPISTOL", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_APPISTOL", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_PISTOL_MK2", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SMOKEGRENADE", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_MOLOTOV", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SHOTGUN_AMMO", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_RIFLE_AMMO", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_SMG_AMMO", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_COMBATPISTOL", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ssddrive", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_goldnecklace", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_WEAPON_VINTAGEPISTOL", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_explosives", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_tarp", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_ritmoneury", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_sulfuric", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_circuit", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "blueprint_horsefigurine", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 }
		}
	},
	["LootCode"] = {
		["Players"] = {},
		["Code"] = "5221",
		["Cooldown"] = 3600,
		["List"] = {
			{ ["Item"] = "bandage", ["Chance"] = 100, ["Min"] = 1, ["Max"] = 1 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEND
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Send(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	local ClosestPed = vRPC.ClosestPed(source)
	if Passport and not Active[Passport] and ClosestPed and not exports["hud"]:Wanted(Passport) then
		local Inv = vRP.Inventory(Passport)
		if not Inv[Slot] or not Inv[Slot].item then
			return false
		end

		local Item = Inv[Slot].item
		local OtherPassport = vRP.Passport(ClosestPed)

		if not vRP.MaxItens(OtherPassport,Item,Amount) then
			if vRP.CheckWeight(OtherPassport,Item,Amount) then
				Active[Passport] = os.time() + 3
				Player(source).state.Cancel = true
				Player(source).state.Buttons = true
				Player(ClosestPed).state.Cancel = true
				Player(ClosestPed).state.Buttons = true
				vRPC.CreateObjects(source,"mp_safehouselost@","package_dropoff","prop_paper_bag_small",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)

				CreateThread(function()
					while Active[Passport] and os.time() < Active[Passport] do
						Wait(100)
					end

					if Active[Passport] then
						vRPC.Destroy(source)
						Active[Passport] = nil
						Player(source).state.Cancel = false
						Player(source).state.Buttons = false
						Player(ClosestPed).state.Cancel = false
						Player(ClosestPed).state.Buttons = false

						if vRP.TakeItem(Passport,Item,Amount,true,Slot) and vRP.GiveItem(OtherPassport,Item,Amount,true) then
							TriggerClientEvent("inventory:Update",source)
							TriggerClientEvent("inventory:Update",ClosestPed)

							return true
						end
					end
				end)
			else
				TriggerClientEvent("inventory:Notify",source,"Aviso","Mochila Sobrecarregada.","amarelo")
			end
		else
			TriggerClientEvent("inventory:Notify",source,"Aviso","Limite atingido.","amarelo",5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Deliver(Work,OtherCoords)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = os.time() + 100

		local Coords = vRP.GetEntityCoords(source)
		if not OtherCoords or #(Coords - OtherCoords) > 2.0 then
			exports["discord"]:Embed("Hackers","**[PASSAPORTE]:** "..Passport.."\n**[FUNÇÃO]:** Payment do Deliver",source)
		end

		if Work == "Lumberman" then
			if not vRPC.LastVehicle(source,"ratloader") then
				TriggerClientEvent("Notify",source,"Atenção","Precisa utilizar o veículo do <b>Lenhador</b>.","amarelo",5000)
				Active[Passport] = nil

				return false
			end

			if vRP.TakeItem(Passport,"woodlog",3,false,Slot) then
				local GainExperience = 3
				local Amount = math.random(125,175)
				local Experience,Level = vRP.GetExperience(Passport,"Lumberman")
				local Valuation = Amount + Amount * (0.05 * Level)

				if exports["party"]:DoesExist(Passport,2) then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if exports["inventory"]:Buffs("Dexterity",Passport) then
					Valuation = Valuation + (Valuation * 0.1)
				end

				for Permission,Multiplier in pairs({ Ouro = 0.1, Prata = 0.075, Bronze = 0.05 }) do
					if vRP.HasService(Passport,Permission) then
						Valuation = Valuation + (Valuation * Multiplier)
						GainExperience = GainExperience + 1
					end
				end

				vRP.PutExperience(Passport,"Lumberman",GainExperience)
				vRP.GenerateItem(Passport,"dollar",Valuation,true)
				vRP.BattlepassPoints(Passport,GainExperience)
				vRP.UpgradeStress(Passport,1)
				Active[Passport] = nil

				return true
			end
		elseif Work == "Milkman" then
			if not vRPC.LastVehicle(source,"youga2") then
				TriggerClientEvent("Notify",source,"Atenção","Precisa utilizar o veículo do <b>Leiteiro</b>.","amarelo",5000)
				Active[Passport] = nil

				return false
			end

			if vRP.TakeItem(Passport,"milkbottle",3,false,Slot) then
				local GainExperience = 3
				local Amount = math.random(125,175)
				local Experience,Level = vRP.GetExperience(Passport,"Milkman")
				local Valuation = Amount + Amount * (0.05 * Level)

				if exports["party"]:DoesExist(Passport,2) then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if exports["inventory"]:Buffs("Dexterity",Passport) then
					Valuation = Valuation + (Valuation * 0.1)
				end

				for Permission,Multiplier in pairs({ Ouro = 0.1, Prata = 0.075, Bronze = 0.05 }) do
					if vRP.HasService(Passport,Permission) then
						Valuation = Valuation + (Valuation * Multiplier)
						GainExperience = GainExperience + 1
					end
				end

				vRP.PutExperience(Passport,"Milkman",GainExperience)
				vRP.GenerateItem(Passport,"dollar",Valuation,true)
				vRP.BattlepassPoints(Passport,GainExperience)
				vRP.UpgradeStress(Passport,1)
				Active[Passport] = nil

				return true
			end
		elseif Work == "Transporter" then
			if not vRPC.LastVehicle(source,"stockade") then
				TriggerClientEvent("Notify",source,"Atenção","Precisa utilizar o veículo do <b>Transportador</b>.","amarelo",5000)
				Active[Passport] = nil

				return false
			end

			if vRP.TakeItem(Passport,"pouch",1,false,Slot) then
				local GainExperience = 1
				local Amount = math.random(75,85)
				local Experience,Level = vRP.GetExperience(Passport,"Transporter")
				local Valuation = Amount + Amount * (0.05 * Level)

				if exports["party"]:DoesExist(Passport,2) then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if exports["inventory"]:Buffs("Dexterity",Passport) then
					Valuation = Valuation + (Valuation * 0.1)
				end

				for Permission,Multiplier in pairs({ Ouro = 0.1, Prata = 0.075, Bronze = 0.05 }) do
					if vRP.HasService(Passport,Permission) then
						Valuation = Valuation + (Valuation * Multiplier)
						GainExperience = GainExperience + 1
					end
				end

				vRP.PutExperience(Passport,"Transporter",GainExperience)
				vRP.GenerateItem(Passport,"dollar",Valuation,true)
				vRP.BattlepassPoints(Passport,GainExperience)
				vRP.UpgradeStress(Passport,1)
				Active[Passport] = nil

				return true
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Use(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		local Inv = vRP.Inventory(Passport)
		if not Inv[Slot] or not Inv[Slot].item then
			return
		end

		local Split = splitString(Inv[Slot].item)
		local Full,Item = Inv[Slot].item,Split[1]

		local WaterItem = ItemWater(Item)
		local WaterEntity = vRPC.IsEntityInWater(source)
		local WaterCondition = WaterItem and ((WaterItem == "Out" and WaterEntity) or (WaterItem == "In" and not WaterEntity))
		if (Player(source).state.Handcuff and Item ~= "lockpick") or WaterCondition or (ItemDurability(Full) and vRP.CheckDamaged(Full)) then
			return
		end

		if ItemTypeCheck(Full,"Armamento") and (parseInt(Slot) >= 100 and parseInt(Slot) <= 104) then
			if vRP.InsideVehicle(source) and not ItemVehicle(Full) then
				return
			end

			if vCLIENT.ReturnWeapon(source) then
				local Check,AmmoClip,Weapon = vCLIENT.StoreWeapon(source)

				if Check then
					local Ammunation = WeaponAmmo(Weapon)
					if Ammunation then
						if AmmoClip > 0 then
							if not Users.Ammos[Passport] then
								Users.Ammos[Passport] = {}
							end

							Users.Ammos[Passport][Ammunation] = AmmoClip
						else
							if Users.Ammos[Passport] and Users.Ammos[Passport][Ammunation] then
								Users.Ammos[Passport][Ammunation] = nil
							end
						end
					end

					TriggerClientEvent("inventory:NotifyItem",source,{ Weapon,-1 })
				end
			else
				local Skin = nil
				local Attach = {}
				local AmmoClip = 0
				local Ammunation = WeaponAmmo(Item)
				if Ammunation and Users.Ammos[Passport] and Users.Ammos[Passport][Ammunation] then
					AmmoClip = Users.Ammos[Passport][Ammunation]
				end

				if Users.Skins[Passport] and Users.Skins[Passport][Item] then
					Skin = Users.Skins[Passport][Item]
				end

				if Users.Attachs[Passport] and Users.Attachs[Passport][Item] then
					Attach = Users.Attachs[Passport][Item]
				end

				if vCLIENT.TakeWeapon(source,Item,AmmoClip,Attach,false,Skin) then
					TriggerClientEvent("inventory:NotifyItem",source,{ Full,1 })
				end
			end
		elseif ItemTypeCheck(Full,"Munição") then
			local Weapon,AmmoClip = vCLIENT.InfoWeapon(source,Item)

			if Weapon ~= "" and WeaponAmmo(Weapon) and Item == WeaponAmmo(Weapon) then
				if Weapon == "WEAPON_PETROLCAN" then
					if (AmmoClip + Amount) > 4500 then
						Amount = 4500 - AmmoClip
					end
				else
					if (AmmoClip + Amount) > 250 then
						Amount = 250 - AmmoClip
					end
				end

				if Amount > 0 and vRP.TakeItem(Passport,Full,Amount,false,Slot) then
					if not Users.Ammos[Passport] then
						Users.Ammos[Passport] = {}
					end

					Users.Ammos[Passport][Item] = AmmoClip + Amount

					TriggerClientEvent("inventory:NotifyItem",source,{ Full,Amount })
					TriggerClientEvent("inventory:Update",source)
					vCLIENT.Reloading(source,Weapon,Amount)
				end
			end
		elseif ItemTypeCheck(Full,"Arremesso") then
			if vCLIENT.ReturnWeapon(source) then
				local Check,AmmoClip,Weapon = vCLIENT.StoreWeapon(source)

				if Check then
					local Amunnation = WeaponAmmo(Weapon)
					if Amunnation then
						if AmmoClip > 0 then
							if not Users.Ammos[Passport] then
								Users.Ammos[Passport] = {}
							end

							Users.Ammos[Passport][Amunnation] = AmmoClip
						else
							if Users.Ammos[Passport] and Users.Ammos[Passport][Amunnation] then
								Users.Ammos[Passport][Amunnation] = nil
							end
						end
					end

					TriggerClientEvent("inventory:NotifyItem",source,{ Weapon,-1 })
				end
			else
				if vCLIENT.TakeWeapon(source,Item,1,nil,Full) then
					TriggerClientEvent("inventory:NotifyItem",source,{ Full,1 })
				end
			end
		elseif ItemTypeCheck(Full,"Attachs") then
			local Weapon = vCLIENT.ReturnWeapon(source)
			if Weapon then
				local Component = WeaponAttach(Item,Weapon)
				if Component then
					if not Users.Attachs[Passport] then
						Users.Attachs[Passport] = {}
					end

					if not Users.Attachs[Passport][Weapon] then
						Users.Attachs[Passport][Weapon] = {}
					end

					local Check = false
					for Name in pairs(Users.Attachs[Passport][Weapon]) do
						if SplitOne(Name) == Item then
							Check = true
						end
					end

					if not Check then
						if vRP.TakeItem(Passport,Full,1,false,Slot) then
							TriggerClientEvent("inventory:NotifyItem",source,{ Full,1 })
							TriggerClientEvent("inventory:Update",source)
							Users.Attachs[Passport][Weapon][Full] = true
							vCLIENT.GiveComponent(source,Component)
						end
					else
						TriggerClientEvent("inventory:Notify",source,"Atenção","O armamento já possui um componente equipado.","vermelho")
					end
				else
					TriggerClientEvent("inventory:Notify",source,"Atenção","O armamento não possui suporte ao componente.","vermelho")
				end
			end
		elseif Use[Item] and ItemTypeCheck(Full,"Consumível") then
			Use[Item](source,Passport,Amount,Slot,Full,Item,Split)
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Cancel")
AddEventHandler("inventory:Cancel",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] then
			Active[Passport] = nil
			vGARAGE.StopHotwired(source)
			TriggerClientEvent("Progress",source,"Cancelando",1000)
		end

		if Player(source)["state"]["Buttons"] then
			Player(source)["state"]["Buttons"] = false
		end

		if Carry[Passport] then
			if vRP.Passport(Carry[Passport]) then
				TriggerClientEvent("inventory:Carry",Carry[Passport],nil,"Detach")
				vRPC.Destroy(Carry[Passport])

				if Player(Carry[Passport])["state"]["Carry"] then
					Player(Carry[Passport])["state"]["Carry"] = false
				end
			end

			if Player(source)["state"]["Carry"] then
				Player(source)["state"]["Carry"] = false
			end

			Carry[Passport] = nil
		end

		if Player(source)["state"]["ItemCamera"] then
			TriggerClientEvent("inventory:Camera",source)
		end

		if Robberys[Passport] then
			TriggerEvent("inventory:RobberyActive",Robberys[Passport].Mode,Robberys[Passport].Number)
			Robberys[Passport] = nil
		end

		vRPC.Destroy(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.VerifyWeapon(Item,Ammo)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not vRP.ConsultItem(Passport,Item,1) then
		local Ammunation = WeaponAmmo(Item)
		if Ammunation and Users["Ammos"][Passport] and Users["Ammos"][Passport][Ammunation] then
			if Ammo and Ammo > 0 then
				Users["Ammos"][Passport][Ammunation] = Ammo
			end

			if Users["Ammos"][Passport][Ammunation] > 0 then
				vRP.GenerateItem(Passport,Ammunation,Users["Ammos"][Passport][Ammunation])
				Users["Ammos"][Passport][Ammunation] = nil
			end
		end

		if Users["Attachs"][Passport] and Users["Attachs"][Passport][Item] then
			for Component,_ in pairs(Users["Attachs"][Passport][Item]) do
				vRP.GenerateItem(Passport,Component,1)
			end

			Users["Attachs"][Passport][Item] = nil
		end

		TriggerClientEvent("inventory:RemoveWeapon",source,Item)
		TriggerClientEvent("inventory:Update",source)

		return false
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKEXISTWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckExistWeapons(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item and not vRP.ConsultItem(Passport,Item,1) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETHROWING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RemoveThrowing(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item ~= nil then
		vRP.TakeItem(Passport,Item)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVENTWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.PreventWeapons(Item,Ammo)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Users["Ammos"][Passport] then
		local Ammunation = WeaponAmmo(Item)

		if Ammunation and Users["Ammos"][Passport][Ammunation] then
			if Ammo > 0 then
				Users["Ammos"][Passport][Ammunation] = Ammo
			else
				Users["Ammos"][Passport][Ammunation] = nil
			end
		end

		if ItemTypeCheck(Item,"Armamento") and vRP.ConsultItem(Passport,Item) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Loot")
AddEventHandler("inventory:Loot",function(Number,Box)
	local Consult = nil
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Loots[Box] then
		if not Loots[Box]["Players"][Number] then
			Loots[Box]["Players"][Number] = {}
		end

		if Loots[Box]["Item"] then
			Consult = vRP.ConsultItem(Passport,Loots[Box]["Item"])
			if not Consult then
				TriggerClientEvent("Notify",source,"Atenção","Precisa de <b>1x "..ItemName(Loots[Box]["Item"]).."</b>.","amarelo",5000)
				return false
			end
		end

		if Loots[Box]["Players"][Number][Passport] then
			if os.time() <= Loots[Box]["Players"][Number][Passport] then
				TriggerClientEvent("Notify",source,"Atenção","Aguarde "..CompleteTimers(Loots[Box]["Players"][Number][Passport] - os.time())..".","amarelo",5000)
				return false
			end
		end

		if Loots[Box]["Code"] then
			local Keyboard = vKEYBOARD.Password(source,"Senha")
			if not Keyboard or (Keyboard[1] and Keyboard[1] ~= Loots[Box]["Code"]) then
				TriggerClientEvent("Notify",source,"Acesso Restrito","Senha incorreta.","vermelho",5000)
				return false
			end
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("Progress",source,"Vasculhando",10000)
		Loots[Box]["Players"][Number][Passport] = os.time() + Loots[Box]["Cooldown"]
		vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

		CreateThread(function()
			while Active[Passport] and os.time() < Active[Passport] do
				Wait(100)
			end

			if Active[Passport] then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if not Loots[Box]["Item"] or (Loots[Box]["Item"] and Consult and vRP.RemoveCharges(Passport,Loots[Box]["Item"])) then
					local Result = RandPercentage(Loots[Box]["List"])
					if not vRP.MaxItens(Passport,Result["Item"],Result["Valuation"]) and vRP.CheckWeight(Passport,Result["Item"],Result["Valuation"]) then
						vRP.GenerateItem(Passport,Result["Item"],Result["Valuation"],true)

						if Loots[Box]["Permission"] and vRP.HasService(Passport,Loots[Box]["Permission"]) then
							vRP.GenerateItem(Passport,"dollar",275,true)
						end
					else
						TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
						exports["inventory"]:Drops(Passport,source,Result["Item"],Result["Valuation"])

						if Loots[Box]["Permission"] and vRP.HasService(Passport,Loots[Box]["Permission"]) then
							exports["inventory"]:Drops(Passport,source,"dollar",275)
						end
					end
				end
			end
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SAVEARENA
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:SaveArena",function(Passport,Att,Amm)
	if not Arena[Passport] then
		Arena[Passport] = {
			["Ammos"] = Users["Ammos"][Passport] or {},
			["Attachs"] = Users["Attachs"][Passport] or {}
		}

		Users["Attachs"][Passport] = Att or {}
		Users["Ammos"][Passport] = Amm or {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:APPLYARENA
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:ApplyArena",function(Passport)
	if Arena[Passport] and Users["Ammos"][Passport] and Users["Attachs"][Passport] then
		Users["Attachs"][Passport] = Arena[Passport]["Attachs"]
		Users["Ammos"][Passport] = Arena[Passport]["Ammos"]
		Arena[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Delete")
AddEventHandler("garages:Delete",function(Network,Plate)
	if Plates[Plate] then
		Plates[Plate] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CHANGEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:ChangePlate")
AddEventHandler("inventory:ChangePlate",function(Entitys)
	local source = source
	local Plate = Entitys[1]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and not Plates[Plate] then
		if not vRP.ConsultItem(Passport,"plate",1) then
			TriggerClientEvent("Notify",source,"Atenção","Precisa de <b>1x "..ItemName("plate").."</b>.","amarelo",5000)

			return false
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("Progress",source,"Trocando",10000)
		vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

		CreateThread(function()
			while Active[Passport] and os.time() < Active[Passport] do
				Wait(100)
			end

			if Active[Passport] then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,"plate",1,true) then
					local Networked = NetworkGetEntityFromNetworkId(Entitys[4])
					if DoesEntityExist(Networked) and not IsPedAPlayer(Networked) and GetEntityType(Networked) == 2 then
						local NewPlate = vRP.GeneratePlate()
						SetVehicleNumberPlateText(Networked,NewPlate)
						Plates[NewPlate] = true

						TriggerEvent("garages:ChangePlate",Plate,NewPlate)

						if not vRP.PassportPlate(NewPlate) then
							Entity(Networked)["state"]:set("Lockpick",Passport,true)
						else
							Entity(Networked)["state"]:set("Lockpick",true,true)
						end
					end
				end
			end
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:StealTrunk")
AddEventHandler("inventory:StealTrunk",function(Entity)
	local source = source
	local Weapon = "WEAPON_CROWBAR"
	local Passport = vRP.Passport(source)
	local Plate,Model = Entity[1],Entity[2]

	if not Passport or Active[Passport] then
		return false
	end

	if not vCLIENT.CheckWeapon(source,Weapon) then
		TriggerClientEvent("Notify",source,"Aviso","<b>"..ItemName(Weapon).."</b> não encontrado.","amarelo",5000)

		return false
	end

	if vRP.PassportPlate(Plate) then
		TriggerClientEvent("Notify",source,"Aviso","Veículo protegido pela seguradora.","amarelo",1000)

		return false
	end

	if Trunks[Plate] and os.time() < Trunks[Plate] then
		TriggerClientEvent("chest:Open",source,"StealTrunk:"..Plate,"Custom",false,true)

		return false
	end

	vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

	if not vRP.Task(source,5,5000) then
		vRPC.Destroy(source)

		return false
	end

	Active[Passport] = os.time() + 15
	Player(source).state.Buttons = true
	TriggerClientEvent("Progress",source,"Vasculhando",15000)
	TriggerClientEvent("player:Residual",source,"Resíduo de Ferro")

	exports["vrp"]:CallPolice({
		Source = source,
		Passport = Passport,
		Permission = "Policia",
		Name = "Roubo de Veículo",
		Vehicle = VehicleName(Model).." - "..Plate,
		Percentage = 925,
		Wanted = 60,
		Color = 44,
		Code = 31
	})

	CreateThread(function()
		while Active[Passport] and os.time() < Active[Passport] do
			Wait(100)
		end

		if Active[Passport] then
			vRPC.Destroy(source)
			Active[Passport] = nil
			Player(source).state.Buttons = false

			if not Trunks[Plate] or os.time() >= Trunks[Plate] then
				Trunks[Plate] = os.time() + 3600

				if vRP.MountContainer(Passport,"StealTrunk:"..Plate,IlegalItens,math.random(2),false,false,{ Item = "dirtydollar", Amount = 100 }) then
					TriggerClientEvent("chest:Open",source,"StealTrunk:"..Plate,"Custom",false,true)
				end
			end
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Animals")
AddEventHandler("inventory:Animals",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Entity[5] then
		local MyEntity,Mode = vCLIENT.Animals(source)

		if MyEntity == Entity[1] then
			if vCLIENT.CheckWeapon(source,"WEAPON_SWITCHBLADE") then
				if vRP.CheckWeight(Passport,"deer1star") then
					Active[Passport] = os.time() + 30
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("Progress",source,"Esfolando",30000)
					vRPC.playAnim(source,false,{"amb@medic@standing@kneel@base","base"},true)
					vRPC.playAnim(source,true,{"anim@gangops@facility@servers@bodysearch@","player_search"},true)

					CreateThread(function()
						while Active[Passport] and os.time() < Active[Passport] do
							Wait(100)
						end

						if Active[Passport] then
							vRPC.Destroy(source)
							Active[Passport] = nil
							Player(source)["state"]["Buttons"] = false

							local Star = math.random(3)

							vRP.UpgradeStress(Passport,Star)
							vRP.BattlepassPoints(Passport,1)
							TriggerEvent("DeletePed",Entity[3])
							vRP.PutExperience(Passport,"Hunting",1)
							vRP.GenerateItem(Passport,"meatfillet",Star,true)
							vRP.GenerateItem(Passport,Mode..Star.."star",1,true)
						end
					end)
				else
					TriggerClientEvent("Notify",source,"Aviso","Mochila Sobrecarregada.","amarelo",5000)
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você precisa do <b>Canivete</b> em mãos.","amarelo",5000)
			end
		else
			TriggerClientEvent("Notify",source,"Atenção","Carcaça animal não é sua.","amarelo",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEPRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Products")
AddEventHandler("inventory:Products",function(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Products[Service] then
		if Products[Service]["PolyZone"] and not vFARMER.PolyZone(source,Service) then
			exports["discord"]:Embed("Hackers","**[PASSAPORTE]:** "..Passport.."\n**[FUNÇÃO]:** Farmer do "..Service,source)

			Payments[Passport] = (Payments[Passport] or 0) + 1
			if Payments[Passport] >= 3 then
				vRP.SetBanned(Passport,-1,"Permanente","Hacker")
			end
		end

		if Products[Service]["Item"] and not vRP.ConsultItem(Passport,Products[Service]["Item"]) then
			TriggerClientEvent("Notify",source,"Atenção","Precisa de <b>1x "..ItemName(Products[Service]["Item"]).."</b>.","amarelo",5000)

			return false
		end

		if Products[Service]["Police"] and not vRP.Task(source,5,5000) then
			exports["vrp"]:CallPolice({
				["Source"] = source,
				["Passport"] = Passport,
				["Permission"] = "Policia",
				["Name"] = "Roubo de Pertences",
				["Wanted"] = 60,
				["Code"] = 31,
				["Color"] = 22
			})
		end

		TriggerClientEvent("Progress",source,"Produzindo",Products[Service]["Timer"] * 1000)
		Active[Passport] = os.time() + Products[Service]["Timer"]
		Player(source)["state"]["Buttons"] = true

		if Products[Service]["Animation"] then
			vRPC.playAnim(source,false,{Products[Service]["Animation"]["Dict"],Products[Service]["Animation"]["Anim"]},true)
		end

		CreateThread(function()
			while Active[Passport] and os.time() < Active[Passport] do
				Wait(100)
			end

			if Active[Passport] then
				Player(source)["state"]["Buttons"] = false
				Active[Passport] = nil

				if Products[Service]["Animation"] then
					vRPC.Destroy(source)
				end

				if not Products[Service]["Item"] or (Products[Service]["Item"] and vRP.TakeItem(Passport,Products[Service]["Item"])) then
					local Result = RandPercentage(Products[Service]["Itens"])
					if not vRP.MaxItens(Passport,Result["Item"],Result["Valuation"]) and vRP.CheckWeight(Passport,Result["Item"],Result["Valuation"]) then
						vRP.GenerateItem(Passport,Result["Item"],Result["Valuation"],true)
					else
						TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
						exports["inventory"]:Drops(Passport,source,Result["Item"],Result["Valuation"])
					end

					if Products[Service]["Residual"] then
						TriggerClientEvent("player:Residual",source,Products[Service]["Residual"])
					end
				end
			end
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:RemoveTyres")
AddEventHandler("inventory:RemoveTyres",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Entity[2] ~= "veto" and Entity[2] ~= "veto2" and VehicleMode(Entity[2]) ~= "Work" then
		if not vCLIENT.CheckWeapon(source,"WEAPON_WRENCH") then
			TriggerClientEvent("Notify",source,"Aviso","<b>Chave Inglesa</b> não encontrada.","amarelo",5000)

			return false
		end

		local Networked = NetworkGetEntityFromNetworkId(Entity[4])
		if DoesEntityExist(Networked) and not IsPedAPlayer(Networked) and GetEntityType(Networked) == 2 then
			if vCLIENT.tyreHealth(source,Entity[4],Entity[6]) == 1000.0 then
				if vRP.MaxItens(Passport,"tyres",1) then
					TriggerClientEvent("Notify",source,"Atenção","Limite atingido.","vermelho",5000)

					return false
				end

				if vRP.PassportPlate(Entity[1]) then
					Player(source)["state"]["Buttons"] = true
					vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

					if vRP.Task(source,5,5000) then
						Active[Passport] = os.time() + 10
						TriggerClientEvent("Progress",source,"Removendo",10000)

						CreateThread(function()
							while Active[Passport] and os.time() < Active[Passport] do
								Wait(100)
							end

							if Active[Passport] then
								Active[Passport] = nil

								local Networked = NetworkGetEntityFromNetworkId(Entity[4])
								if DoesEntityExist(Networked) and not IsPedAPlayer(Networked) and GetEntityType(Networked) == 2 then
									if vCLIENT.tyreHealth(source,Entity[4],Entity[6]) == 1000.0 then
										local Players = vRPC.Players(source)
										for _,v in pairs(Players) do
											async(function()
												TriggerClientEvent("inventory:explodeTyres",v,Entity[4],Entity[1],Entity[6])
											end)
										end

										vRP.GenerateItem(Passport,"tyres",1,true)
									end
								end
							end
						end)
					end

					Player(source)["state"]["Buttons"] = false
					vRPC.Destroy(source)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDATA:SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("itemdata:Save")
AddEventHandler("itemdata:Save",function(Item,Text)
	vRP.SetSrvData(Item,Text,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ROLLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:RollVehicle")
AddEventHandler("player:RollVehicle",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 60
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("Progress",source,"Desvirando",60000)
		vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

		CreateThread(function()
			while Active[Passport] and os.time() < Active[Passport] do
				Wait(100)
			end

			if Active[Passport] then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				local Players = vRPC.Players(source)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("target:RollVehicle",v,Entity[4])
					end)
				end
			end
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:BUFFSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:BuffServer",function(source,Passport,Name,Amount)
	if not Buffs[Name][Passport] then
		Buffs[Name][Passport] = 0
	end

	if os.time() >= Buffs[Name][Passport] then
		Buffs[Name][Passport] = os.time() + Amount
	else
		Buffs[Name][Passport] = Buffs[Name][Passport] + Amount

		if (Buffs[Name][Passport] - os.time()) >= 3600 then
			Buffs[Name][Passport] = os.time() + 3600
		end
	end

	TriggerClientEvent("hud:"..Name,source,Buffs[Name][Passport] - os.time())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Buffs",function(Mode,Passport)
	return Buffs[Mode] and Buffs[Mode][Passport] and Buffs[Mode][Passport] > os.time() and (Mode ~= "Luck" or (Mode == "Luck" and math.random(100) >= 50)) and true or false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("CleanWeapons",function(Passport)
	Users["Attachs"][Passport] = {}
	Users["Ammos"][Passport] = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StealPeds()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Result = RandPercentage(IlegalItens)
		if not vRP.MaxItens(Passport,Result["Item"],Result["Valuation"]) and vRP.CheckWeight(Passport,Result["Item"],Result["Valuation"]) then
			vRP.GenerateItem(Passport,Result["Item"],Result["Valuation"],true)
		else
			TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
			exports["inventory"]:Drops(Passport,source,Result["Item"],Result["Valuation"])
		end

		if math.random(100) >= 75 and vRP.DoesEntityExist(source) then
			exports["vrp"]:CallPolice({
				["Source"] = source,
				["Passport"] = Passport,
				["Permission"] = "Policia",
				["Name"] = "Assalto a mão armada",
				["Wanted"] = 60,
				["Code"] = 32,
				["Color"] = 16
			})
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ShotsFired(Vehicle)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Vehicle then
			Vehicle = "Disparos de um veículo"
		else
			Vehicle = "Disparos com arma de fogo"
		end

		if vRP.DoesEntityExist(source) then
			exports["vrp"]:CallPolice({
				["Source"] = source,
				["Passport"] = Passport,
				["Permission"] = "Policia",
				["Name"] = Vehicle,
				["Code"] = 10,
				["Color"] = 6
			})
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRINK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Drink")
AddEventHandler("inventory:Drink",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"amb@world_human_drinking@coffee@male@idle_a","idle_c","prop_plastic_cup_02",49,28422)

		CreateThread(function()
			while Active[Passport] and os.time() < Active[Passport] do
				Wait(100)
			end

			if Active[Passport] then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				vRP.UpgradeThirst(Passport,10)
				Player(source)["state"]["Buttons"] = false
			end
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REFILLGALLON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:RefillGallon")
AddEventHandler("inventory:RefillGallon",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and vRP.ConsultItem(Passport,"emptypurifiedwater") then
		Active[Passport] = os.time() + 30
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("Progress",source,"Enchendo",30000)
		vRPC.playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)

		CreateThread(function()
			while Active[Passport] and os.time() < Active[Passport] do
				Wait(100)
			end

			if Active[Passport] then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,"emptypurifiedwater") then
					vRP.GenerateItem(Passport,"purifiedwater",1)
				end
			end
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer",function(Silenced)
	local List = vRP.Players()
	for Passport,_ in pairs(List) do
		if Users["Ammos"] and Users["Ammos"][Passport] then
			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Ammos", Information = json.encode(Users["Ammos"][Passport]) })
		end

		if Users["Attachs"] and Users["Attachs"][Passport] then
			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Attachs", Information = json.encode(Users["Attachs"][Passport]) })
		end

		if Users["Skins"] and Users["Skins"][Passport] then
			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Skins", Information = json.encode(Users["Skins"][Passport]) })
		end

		if Users["Blueprints"] and Users["Blueprints"][Passport] then
			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Blueprints", Information = json.encode(Users["Blueprints"][Passport]) })
		end
	end

	vRP.Query("entitydata/SetData",{ Name = "SaveObjects", Information = json.encode(SaveObjects) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Users["Ammos"] and Users["Ammos"][Passport] then
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Ammos", Information = json.encode(Users["Ammos"][Passport]) })
		Users["Ammos"][Passport] = nil
	end

	if Users["Attachs"] and Users["Attachs"][Passport] then
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Attachs", Information = json.encode(Users["Attachs"][Passport]) })
		Users["Attachs"][Passport] = nil
	end

	if Users["Skins"] and Users["Skins"][Passport] then
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Skins", Information = json.encode(Users["Skins"][Passport]) })
		Users["Skins"][Passport] = nil
	end

	if Users["Blueprints"] and Users["Blueprints"][Passport] then
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Blueprints", Information = json.encode(Users["Blueprints"][Passport]) })
		Users["Blueprints"][Passport] = nil
	end

	if Active[Passport] then
		Active[Passport] = nil
	end

	if Payments[Passport] then
		Payments[Passport] = nil
	end

	if Drugs[Passport] then
		Drugs[Passport] = nil
	end

	if Carry[Passport] then
		if vRP.Passport(Carry[Passport]) then
			TriggerClientEvent("inventory:Carry",Carry[Passport],nil,"Detach")
			vRPC.Destroy(Carry[Passport])

			if Player(Carry[Passport])["state"]["Carry"] then
				Player(Carry[Passport])["state"]["Carry"] = false
			end
		end

		Carry[Passport] = nil
	end

	if Robberys[Passport] then
		TriggerEvent("inventory:RobberyActive",Robberys[Passport].Mode,Robberys[Passport].Number)
		Robberys[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	if not Users["Ammos"][Passport] then
		Users["Ammos"][Passport] = vRP.UserData(Passport,"Ammos")
	end

	if not Users["Skins"][Passport] then
		Users["Skins"][Passport] = vRP.UserData(Passport,"Skins")
	end

	if not Users["Attachs"][Passport] then
		Users["Attachs"][Passport] = vRP.UserData(Passport,"Attachs")
	end

	if not Users["Blueprints"][Passport] then
		Users["Blueprints"][Passport] = vRP.UserData(Passport,"Blueprints")
	end

	TriggerClientEvent("objects:Table",source,Objects)
	TriggerClientEvent("inventory:Drops",source,Drops)
	TriggerClientEvent("inventory:Skins",source,Users["Skins"][Passport])

	for Name,_ in pairs(Buffs) do
		if Buffs[Name] and Buffs[Name][Passport] and os.time() < Buffs[Name][Passport] then
			TriggerClientEvent("hud:"..Name,source,Buffs[Name][Passport] - os.time())
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLUEPRINT
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Blueprint",function(Passport,Item)
	return Users["Blueprints"][Passport] and Users["Blueprints"][Passport][Item]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
MarketplaceTax = 0.03 -- Taxa em cima do valor do item anunciado.
SalaryCooldown = 1800 -- Quantidade de segundos.
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOXES
-----------------------------------------------------------------------------------------------------------------------------------------
Boxes = {
	{
		Id = 1,
		Name = "Caixa de Diamantes",
		Image = "gemstone",
		Price = 500,
		Discount = 1.0,
		Rewards = {
			{
				Id = 1,
				Amount = 250,
				Image = "gemstone",
				Item = "gemstone",
				Name = "Diamante",
				Chance = 500
			},{
				Id = 2,
				Amount = 375,
				Image = "gemstone",
				Item = "gemstone",
				Name = "Diamante",
				Chance = 250
			},{
				Id = 3,
				Amount = 500,
				Image = "gemstone",
				Item = "gemstone",
				Name = "Diamante",
				Chance = 200
			},{
				Id = 4,
				Amount = 625,
				Image = "gemstone",
				Item = "gemstone",
				Name = "Diamante",
				Chance = 150
			},{
				Id = 5,
				Amount = 750,
				Image = "gemstone",
				Item = "gemstone",
				Name = "Diamante",
				Chance = 100
			},{
				Id = 6,
				Amount = 1000,
				Image = "gemstone",
				Item = "gemstone",
				Name = "Diamante",
				Chance = 5
			},{
				Id = 7,
				Amount = 2000,
				Image = "gemstone",
				Item = "gemstone",
				Name = "Diamante",
				Chance = 4
			},{
				Id = 8,
				Amount = 3000,
				Image = "gemstone",
				Item = "gemstone",
				Name = "Diamante",
				Chance = 3
			},{
				Id = 9,
				Amount = 4000,
				Image = "gemstone",
				Item = "gemstone",
				Name = "Diamante",
				Chance = 2
			},{
				Id = 10,
				Amount = 5000,
				Image = "gemstone",
				Item = "gemstone",
				Name = "Diamante",
				Chance = 1
			},{
				Id = 11,
				Amount = 10000,
				Image = "gemstone",
				Item = "gemstone",
				Name = "Diamante",
				Chance = 0
			},{
				Id = 12,
				Amount = 20000,
				Image = "gemstone",
				Item = "gemstone",
				Name = "Diamante",
				Chance = 0
			}
		}
	},{
		Id = 2,
		Name = "Caixa de Platinas",
		Image = "platinum",
		Price = 1000,
		Discount = 1.0,
		Rewards = {
			{
				Id = 1,
				Amount = 500,
				Image = "platinum",
				Item = "platinum",
				Name = "Platina",
				Chance = 300
			},{
				Id = 2,
				Amount = 750,
				Image = "platinum",
				Item = "platinum",
				Name = "Platina",
				Chance = 200
			},{
				Id = 3,
				Amount = 1000,
				Image = "platinum",
				Item = "platinum",
				Name = "Platina",
				Chance = 175
			},{
				Id = 4,
				Amount = 1250,
				Image = "platinum",
				Item = "platinum",
				Name = "Platina",
				Chance = 150
			},{
				Id = 5,
				Amount = 1500,
				Image = "platinum",
				Item = "platinum",
				Name = "Platina",
				Chance = 100
			},{
				Id = 6,
				Amount = 2000,
				Image = "platinum",
				Item = "platinum",
				Name = "Platina",
				Chance = 5
			},{
				Id = 7,
				Amount = 3000,
				Image = "platinum",
				Item = "platinum",
				Name = "Platina",
				Chance = 4
			},{
				Id = 8,
				Amount = 4000,
				Image = "platinum",
				Item = "platinum",
				Name = "Platina",
				Chance = 3
			},{
				Id = 9,
				Amount = 5000,
				Image = "platinum",
				Item = "platinum",
				Name = "Platina",
				Chance = 2
			},{
				Id = 10,
				Amount = 7500,
				Image = "platinum",
				Item = "platinum",
				Name = "Platina",
				Chance = 1
			},{
				Id = 11,
				Amount = 10000,
				Image = "platinum",
				Item = "platinum",
				Name = "Platina",
				Chance = 0
			},{
				Id = 12,
				Amount = 20000,
				Image = "platinum",
				Item = "platinum",
				Name = "Platina",
				Chance = 0
			}
		}
	},{
		Id = 3,
		Name = "Caixa de Alumínio",
		Image = "aluminum",
		Price = 500,
		Discount = 1.0,
		Rewards = {
			{
				Id = 1,
				Amount = 500,
				Image = "aluminum",
				Item = "aluminum",
				Name = "Alumínio",
				Chance = 500
			},{
				Id = 2,
				Amount = 750,
				Image = "aluminum",
				Item = "aluminum",
				Name = "Alumínio",
				Chance = 250
			},{
				Id = 3,
				Amount = 1000,
				Image = "aluminum",
				Item = "aluminum",
				Name = "Alumínio",
				Chance = 200
			},{
				Id = 4,
				Amount = 1250,
				Image = "aluminum",
				Item = "aluminum",
				Name = "Alumínio",
				Chance = 150
			},{
				Id = 5,
				Amount = 1500,
				Image = "aluminum",
				Item = "aluminum",
				Name = "Alumínio",
				Chance = 100
			},{
				Id = 6,
				Amount = 2250,
				Image = "aluminum",
				Item = "aluminum",
				Name = "Alumínio",
				Chance = 10
			}
		}
	},{
		Id = 4,
		Name = "Caixa de Vidro",
		Image = "glass",
		Price = 500,
		Discount = 1.0,
		Rewards = {
			{
				Id = 1,
				Amount = 500,
				Image = "glass",
				Item = "glass",
				Name = "Vidro",
				Chance = 500
			},{
				Id = 2,
				Amount = 750,
				Image = "glass",
				Item = "glass",
				Name = "Vidro",
				Chance = 250
			},{
				Id = 3,
				Amount = 1000,
				Image = "glass",
				Item = "glass",
				Name = "Vidro",
				Chance = 200
			},{
				Id = 4,
				Amount = 1250,
				Image = "glass",
				Item = "glass",
				Name = "Vidro",
				Chance = 150
			},{
				Id = 5,
				Amount = 1500,
				Image = "glass",
				Item = "glass",
				Name = "Vidro",
				Chance = 100
			},{
				Id = 6,
				Amount = 2250,
				Image = "glass",
				Item = "glass",
				Name = "Vidro",
				Chance = 10
			}
		}
	},{
		Id = 5,
		Name = "Caixa de Cobre",
		Image = "copper",
		Price = 500,
		Discount = 1.0,
		Rewards = {
			{
				Id = 1,
				Amount = 500,
				Image = "copper",
				Item = "copper",
				Name = "Cobre",
				Chance = 500
			},{
				Id = 2,
				Amount = 750,
				Image = "copper",
				Item = "copper",
				Name = "Cobre",
				Chance = 250
			},{
				Id = 3,
				Amount = 1000,
				Image = "copper",
				Item = "copper",
				Name = "Cobre",
				Chance = 200
			},{
				Id = 4,
				Amount = 1250,
				Image = "copper",
				Item = "copper",
				Name = "Cobre",
				Chance = 150
			},{
				Id = 5,
				Amount = 1500,
				Image = "copper",
				Item = "copper",
				Name = "Cobre",
				Chance = 100
			},{
				Id = 6,
				Amount = 2250,
				Image = "copper",
				Item = "copper",
				Name = "Cobre",
				Chance = 10
			}
		}
	},{
		Id = 6,
		Name = "Caixa de Borracha",
		Image = "rubber",
		Price = 500,
		Discount = 1.0,
		Rewards = {
			{
				Id = 1,
				Amount = 500,
				Image = "rubber",
				Item = "rubber",
				Name = "Borracha",
				Chance = 500
			},{
				Id = 2,
				Amount = 750,
				Image = "rubber",
				Item = "rubber",
				Name = "Borracha",
				Chance = 250
			},{
				Id = 3,
				Amount = 1000,
				Image = "rubber",
				Item = "rubber",
				Name = "Borracha",
				Chance = 200
			},{
				Id = 4,
				Amount = 1250,
				Image = "rubber",
				Item = "rubber",
				Name = "Borracha",
				Chance = 150
			},{
				Id = 5,
				Amount = 1500,
				Image = "rubber",
				Item = "rubber",
				Name = "Borracha",
				Chance = 100
			},{
				Id = 6,
				Amount = 2250,
				Image = "rubber",
				Item = "rubber",
				Name = "Borracha",
				Chance = 10
			}
		}
	},{
		Id = 7,
		Name = "Caixa de Plástico",
		Image = "plastic",
		Price = 500,
		Discount = 1.0,
		Rewards = {
			{
				Id = 1,
				Amount = 500,
				Image = "plastic",
				Item = "plastic",
				Name = "Plástico",
				Chance = 500
			},{
				Id = 2,
				Amount = 750,
				Image = "plastic",
				Item = "plastic",
				Name = "Plástico",
				Chance = 250
			},{
				Id = 3,
				Amount = 1000,
				Image = "plastic",
				Item = "plastic",
				Name = "Plástico",
				Chance = 200
			},{
				Id = 4,
				Amount = 1250,
				Image = "plastic",
				Item = "plastic",
				Name = "Plástico",
				Chance = 150
			},{
				Id = 5,
				Amount = 1500,
				Image = "plastic",
				Item = "plastic",
				Name = "Plástico",
				Chance = 100
			},{
				Id = 6,
				Amount = 2250,
				Image = "plastic",
				Item = "plastic",
				Name = "Plástico",
				Chance = 10
			}
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
Works = {
	Grime = "Grime",
	Taxi = "Taxista",
	Towed = "Impound",
	Dismantle = "Desmanche",
	Delivery = "Entregador",
	Transporter = "Transportador",
	Lumberman = "Lenhador",
	Milkman = "Leiteiro",
	Trucker = "Caminhoneiro",
	Fisherman = "Pescador",
	Driver = "Motorista",
	Traffic = "Traficante",
	Hunting = "Caçador",
	Garbageman = "Lixeiro",
	Race = "Corredor",
	Throwing = "Entregador de Jornal"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
Premium = {
	{
		Name = "Ouro",
		Image = "gold",
		Permission = "Ouro",
		Price = 20000,
		Discount = 1.0,
		Duration = 2592000,
		Rewards = {
			{
				Type = "Info",
				Name = "Reduz 20% de quebrar a Lockpick"
			},{
				Type = "Info",
				Name = "Recebe 100 Kilos de peso na mochila"
			},{
				Type = "Info",
				Name = "20% de bonificação nos empregos"
			},{
				Type = "Info",
				Name = "Salário de $10.000 a cada 30 minutos"
			},{
				Type = "Info",
				Name = "75% de desconto em todos os impostos"
			},{
				Type = "Vehicle",
				Name = "Veículo Básico"
			},{
				Type = "Vehicle",
				Name = "Veículo Esportivo"
			}
		},
		Selectables = {
			{
				Name = "Veículo Básico",
				Options = {
					{
						Name = "Panto",
						Index = "panto"
					},{
						Name = "Brioso",
						Index = "brioso"
					}
				}
			},{
				Name = "Veículo Esportivo",
				Options = {
					{
						Name = "Sultan",
						Index = "sultan"
					},{
						Name = "Sultan RS",
						Index = "sultanrs"
					}
				}
			}
		}
	},{
		Name = "Prata",
		Image = "silver",
		Permission = "Prata",
		Price = 10000,
		Discount = 1.0,
		Duration = 2592000,
		Rewards = {
			{
				Type = "Info",
				Name = "Reduz 10% de quebrar a Lockpick"
			},{
				Type = "Info",
				Name = "50 Kilos de peso na mochila"
			},{
				Type = "Info",
				Name = "10% de bonificação nos empregos"
			},{
				Type = "Info",
				Name = "Salário de $5.000 a cada 30 minutos"
			},{
				Type = "Info",
				Name = "50% de desconto em todos os impostos"
			}
		}
	},{
		Name = "Bronze",
		Image = "bronze",
		Permission = "Bronze",
		Price = 5000,
		Discount = 1.0,
		Duration = 2592000,
		Rewards = {
			{
				Type = "Info",
				Name = "Reduz 5% de quebrar a Lockpick"
			},{
				Type = "Info",
				Name = "25 Kilos de peso na mochila"
			},{
				Type = "Info",
				Name = "5% de bonificação nos empregos"
			},{
				Type = "Info",
				Name = "Salário de $2.500 a cada 30 minutos"
			},{
				Type = "Info",
				Name = "25% de desconto em todos os impostos"
			}
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
Propertys = {
	{
		Name = "Fazenda",
		Image = "fazenda",
		Permission = "Fazenda",
		Coords = vec3(0.0,0.0,0.0),
		Price = 100000,
		Discount = 1.0,
		Duration = 2592000,
		Rewards = {
			"Textos da descrição. 01",
			"Textos da descrição. 02",
			"Textos da descrição. 03"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPITENS
-----------------------------------------------------------------------------------------------------------------------------------------
ShopItens = {
	gemstone = {
		Price = 1,
		Discount = 1.0,
		Category = "Diamantes"
	},
	skinshop = {
		Price = 25000,
		Discount = 1.0,
		Category = "Grupos"
	},
	barbershop = {
		Price = 25000,
		Discount = 1.0,
		Category = "Grupos"
	},
	tattooshop = {
		Price = 25000,
		Discount = 1.0,
		Category = "Grupos"
	},
	premiumplate = {
		Price = 5000,
		Discount = 1.0,
		Category = "Veículos"
	},
	newchars = {
		Price = 4000,
		Discount = 1.0,
		Category = "Utilidades"
	},
	namechange = {
		Price = 3000,
		Discount = 1.0,
		Category = "Utilidades"
	},
	diagram = {
		Price = 500,
		Discount = 1.0,
		Category = "Utilidades"
	},
	WEAPON_KATANA = {
		Price = 500,
		Discount = 1.0,
		Category = "Armamentos"
	},
	pickaxeplus = {
		Price = 2500,
		Discount = 1.0,
		Category = "Empregos"
	},
	fishingrodplus = {
		Price = 2500,
		Discount = 1.0,
		Category = "Empregos"
	},
	axeplus = {
		Price = 2500,
		Discount = 1.0,
		Category = "Empregos"
	},
	backpackp = {
		Price = 2000,
		Discount = 1.0,
		Category = "Vestimentas"
	},
	backpackm = {
		Price = 3500,
		Discount = 1.0,
		Category = "Vestimentas"
	},
	backpackg = {
		Price = 5000,
		Discount = 1.0,
		Category = "Vestimentas"
	},
	teddypack = {
		Price = 5000,
		Discount = 1.0,
		Category = "Vestimentas"
	},
	weaponbox = {
		Price = 5000,
		Discount = 1.0,
		Category = "Armamentos"
	},
	ammobox = {
		Price = 3500,
		Discount = 1.0,
		Category = "Armamentos"
	},
	sewingkit = {
		Price = 2500,
		Discount = 1.0,
		Category = "Utilidades"
	},
	seatbelt = {
		Price = 5000,
		Discount = 1.0,
		Category = "Veículos"
	},
	adrenalineplus = {
		Price = 500,
		Discount = 1.0,
		Category = "Medicamentos"
	},
	moneywash = {
		Price = 5000,
		Discount = 1.0,
		Category = "Lavagem"
	},
	moneywashplus = {
		Price = 10000,
		Discount = 0.95,
		Category = "Lavagem"
	},
	moneywashalpha = {
		Price = 20000,
		Discount = 0.90,
		Category = "Lavagem"
	},
	moneywashomega = {
		Price = 100000,
		Discount = 0.85,
		Category = "Lavagem"
	},
	washbattery = {
		Price = 750,
		Discount = 1.0,
		Category = "Lavagem"
	},
	washbleach = {
		Price = 500,
		Discount = 1.0,
		Category = "Lavagem"
	},
	radiomhz = {
		Price = 7500,
		Discount = 1.0,
		Category = "Utilidades"
	},
	a_c_cat_01 = {
		Price = 5000,
		Discount = 1.0,
		Category = "Domésticos"
	},
	a_c_husky = {
		Price = 5000,
		Discount = 1.0,
		Category = "Domésticos"
	},
	a_c_poodle = {
		Price = 5000,
		Discount = 1.0,
		Category = "Domésticos"
	},
	a_c_pug = {
		Price = 5000,
		Discount = 1.0,
		Category = "Domésticos"
	},
	a_c_retriever = {
		Price = 5000,
		Discount = 1.0,
		Category = "Domésticos"
	},
	a_c_rottweiler = {
		Price = 5000,
		Discount = 1.0,
		Category = "Domésticos"
	},
	a_c_shepherd = {
		Price = 5000,
		Discount = 1.0,
		Category = "Domésticos"
	},
	a_c_westy = {
		Price = 5000,
		Discount = 1.0,
		Category = "Domésticos"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROLEITENS
-----------------------------------------------------------------------------------------------------------------------------------------
RoleItens = {
	Free = {
		{
			Amount = 1000,
			Item = "dollar"
		},{
			Amount = 1000,
			Item = "dollar"
		},{
			Amount = 1000,
			Item = "dollar"
		},{
			Amount = 1,
			Item = "repairkit01"
		},{
			Amount = 1,
			Item = "repairkit02"
		},{
			Amount = 1,
			Item = "repairkit03"
		},{
			Amount = 1000,
			Item = "dollar"
		},{
			Amount = 1250,
			Item = "dollar"
		},{
			Amount = 1500,
			Item = "dollar"
		},{
			Amount = 1750,
			Item = "dollar"
		},{
			Amount = 1,
			Item = "medkit"
		},{
			Amount = 3,
			Item = "bandage"
		},{
			Amount = 3,
			Item = "analgesic"
		},{
			Amount = 5,
			Item = "gauze"
		},{
			Amount = 1,
			Item = "medicalkey"
		},{
			Amount = 1,
			Item = "utilkey"
		},{
			Amount = 3,
			Item = "toolbox"
		},{
			Amount = 1,
			Item = "advtoolbox"
		},{
			Amount = 1,
			Item = "adrenalineplus"
		},{
			Amount = 100,
			Item = "plastic"
		},{
			Amount = 100,
			Item = "glass"
		},{
			Amount = 100,
			Item = "rubber"
		},{
			Amount = 100,
			Item = "aluminum"
		},{
			Amount = 100,
			Item = "copper"
		},{
			Amount = 275,
			Item = "blueprint_fragment"
		},{
			Amount = 325,
			Item = "blueprint_fragment"
		},{
			Amount = 375,
			Item = "blueprint_fragment"
		},{
			Amount = 1,
			Item = "television"
		},{
			Amount = 1,
			Item = "safependrive"
		},{
			Amount = 1,
			Item = "goldenjug"
		}
	},
	Premium = {
		{
			Amount = 2500,
			Item = "dollar"
		},{
			Amount = 2750,
			Item = "dollar"
		},{
			Amount = 3000,
			Item = "dollar"
		},{
			Amount = 1,
			Item = "repairkit01"
		},{
			Amount = 1,
			Item = "repairkit02"
		},{
			Amount = 1,
			Item = "repairkit03"
		},{
			Amount = 1,
			Item = "repairkit04"
		},{
			Amount = 3,
			Item = "toolbox"
		},{
			Amount = 3,
			Item = "advtoolbox"
		},{
			Amount = 2500,
			Item = "dollar"
		},{
			Amount = 2750,
			Item = "dollar"
		},{
			Amount = 3000,
			Item = "dollar"
		},{
			Amount = 1,
			Item = "backpackp"
		},{
			Amount = 3,
			Item = "adrenalineplus"
		},{
			Amount = 3,
			Item = "diagram"
		},{
			Amount = 3,
			Item = "diagram"
		},{
			Amount = 225,
			Item = "plastic"
		},{
			Amount = 225,
			Item = "glass"
		},{
			Amount = 225,
			Item = "rubber"
		},{
			Amount = 225,
			Item = "aluminum"
		},{
			Amount = 225,
			Item = "copper"
		},{
			Amount = 625,
			Item = "blueprint_fragment"
		},{
			Amount = 725,
			Item = "blueprint_fragment"
		},{
			Amount = 825,
			Item = "blueprint_fragment"
		},{
			Amount = 928,
			Item = "blueprint_fragment"
		},{
			Amount = 1,
			Item = "goldenleopard"
		},{
			Amount = 1,
			Item = "goldenlion"
		},{
			Amount = 1,
			Item = "blueprint_bench"
		},{
			Amount = 1,
			Item = "goldenjug"
		},{
			Amount = 1,
			Item = "moneywash"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Daily = {
	{
		blue_essence = 10
	},{
		blue_essence = 10
	},{
		blue_essence = 20
	},{
		blue_essence = 20
	},{
		blue_essence = 30
	},{
		blue_essence = 30
	},{
		blue_essence = 40
	},{
		blue_essence = 40
	},{
		blue_essence = 50
	},{
		blue_essence = 50
	}
}
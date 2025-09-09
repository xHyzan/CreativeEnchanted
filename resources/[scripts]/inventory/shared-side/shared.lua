-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
DistanceDrops = 25
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
Sprays = {
	spray_ballas = { "Ballas",50 },
	spray_vagos = { "Vagos",60 },
	spray_families = { "Families",69 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
Crafting = {
	bandage = {
		Amount = 1,
		Required = {
			gauze = 5
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
Missions = {
	{
		Xp = 100,
		Code = "MISSION01",
		Title = "Titulo da missão",
		Description = "Descrição da missão",
		Required = {
			blue_essence = 10
		},
		Rewards = {
			purple_essence = 10
		}
	},{
		Xp = 1000,
		Code = "MISSION02",
		Title = "Titulo da missão 2",
		Description = "Descrição da missão 2",
		Required = {
			purple_essence = 10
		},
		Rewards = {
			green_essence = 10
		}
	},{
		Xp = 10000,
		Code = "MISSION03",
		Title = "Titulo da missão 3",
		Description = "Descrição da missão 3",
		Required = {
			green_essence = 10
		},
		Rewards = {
			red_essence = 10
		}
	},{
		Xp = 50000,
		Code = "MISSION04",
		Title = "Titulo da missão 4",
		Description = "Descrição da missão 4",
		Required = {
			red_essence = 10
		},
		Rewards = {
			pink_essence = 10
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
Robbery = {
	{ Coords = vec3(256.35,-47.51,69.7), Mode = "Ammunation" },
	{ Coords = vec3(846.13,-1036.62,27.95), Mode = "Ammunation" },
	{ Coords = vec3(-335.18,6083.29,31.21), Mode = "Ammunation" },
	{ Coords = vec3(-665.98,-932.24,21.58), Mode = "Ammunation" },
	{ Coords = vec3(-1301.93,-391.36,36.45), Mode = "Ammunation" },
	{ Coords = vec3(-1122.59,2698.25,18.31), Mode = "Ammunation" },
	{ Coords = vec3(2571.67,291.28,108.49), Mode = "Ammunation" },
	{ Coords = vec3(2571.66,291.29,108.49), Mode = "Ammunation" },
	{ Coords = vec3(19.57,-1103.0,29.55), Mode = "Ammunation" },
	{ Coords = vec3(813.92,-2160.34,29.37), Mode = "Ammunation" },
	{ Coords = vec3(1688.78,3759.13,34.46), Mode = "Ammunation" },

	{ Coords = vec3(28.18,-1338.55,29.24), Mode = "Department" },
	{ Coords = vec3(2548.61,384.87,108.36), Mode = "Department" },
	{ Coords = vec3(1159.12,-316.72,68.95), Mode = "Department" },
	{ Coords = vec3(-710.58,-906.72,18.96), Mode = "Department" },
	{ Coords = vec3(-45.73,-1749.8,29.17), Mode = "Department" },
	{ Coords = vec3(378.3,334.01,103.31), Mode = "Department" },
	{ Coords = vec3(-3250.66,1004.43,12.57), Mode = "Department" },
	{ Coords = vec3(1735.06,6421.41,34.78), Mode = "Department" },
	{ Coords = vec3(546.53,2662.18,41.89), Mode = "Department" },
	{ Coords = vec3(1958.93,3749.46,32.09), Mode = "Department" },
	{ Coords = vec3(2672.21,3286.9,54.98), Mode = "Department" },
	{ Coords = vec3(1706.27,4922.6,41.81), Mode = "Department" },
	{ Coords = vec3(-1828.06,796.31,137.93), Mode = "Department" },
	{ Coords = vec3(-3048.43,585.41,7.66), Mode = "Department" },

	{ Coords = vec3(24.97,-1344.95,29.68), Mode = "Register" },
	{ Coords = vec3(24.96,-1347.28,29.68), Mode = "Register" },
	{ Coords = vec3(2554.88,381.41,108.81), Mode = "Register" },
	{ Coords = vec3(2557.21,381.33,108.81), Mode = "Register" },
	{ Coords = vec3(1164.19,-322.88,69.39), Mode = "Register" },
	{ Coords = vec3(1164.55,-324.89,69.39), Mode = "Register" },
	{ Coords = vec3(-706.65,-913.68,19.4), Mode = "Register" },
	{ Coords = vec3(-706.66,-915.72,19.4), Mode = "Register" },
	{ Coords = vec3(-47.22,-1757.64,29.6), Mode = "Register" },
	{ Coords = vec3(-48.53,-1759.21,29.6), Mode = "Register" },
	{ Coords = vec3(373.63,328.58,103.75), Mode = "Register" },
	{ Coords = vec3(373.06,326.32,103.75), Mode = "Register" },
	{ Coords = vec3(-3244.57,1000.68,13.01), Mode = "Register" },
	{ Coords = vec3(-3242.24,1000.47,13.01), Mode = "Register" },
	{ Coords = vec3(1729.35,6417.12,35.22), Mode = "Register" },
	{ Coords = vec3(1728.3,6415.03,35.22), Mode = "Register" },
	{ Coords = vec3(548.88,2668.95,42.34), Mode = "Register" },
	{ Coords = vec3(548.58,2671.26,42.34), Mode = "Register" },
	{ Coords = vec3(1959.35,3742.31,32.53), Mode = "Register" },
	{ Coords = vec3(1960.52,3740.29,32.53), Mode = "Register" },
	{ Coords = vec3(2676.23,3280.99,55.42), Mode = "Register" },
	{ Coords = vec3(2678.27,3279.85,55.42), Mode = "Register" },
	{ Coords = vec3(1698.32,4923.39,42.25), Mode = "Register" },
	{ Coords = vec3(1696.66,4924.55,42.25), Mode = "Register" },
	{ Coords = vec3(-1820.47,793.81,138.28), Mode = "Register" },
	{ Coords = vec3(-1819.09,792.32,138.27), Mode = "Register" },
	{ Coords = vec3(1393.08,3605.96,35.18), Mode = "Register" },
	{ Coords = vec3(-2967.04,390.91,15.22), Mode = "Register" },
	{ Coords = vec3(-3041.35,584.28,8.09), Mode = "Register" },
	{ Coords = vec3(-3039.13,584.99,8.09), Mode = "Register" },
	{ Coords = vec3(1134.83,-982.36,46.59), Mode = "Register" },
	{ Coords = vec3(1165.96,2710.2,38.33), Mode = "Register" },
	{ Coords = vec3(-1486.68,-378.47,40.34), Mode = "Register" },
	{ Coords = vec3(-1222.32,-907.81,12.5), Mode = "Register" },
	{ Coords = vec3(-160.66,6321.81,31.76), Mode = "Register" },
	{ Coords = vec3(1693.59,3761.59,34.89), Mode = "Register" },
	{ Coords = vec3(1693.32,3755.67,34.89), Mode = "Register" },
	{ Coords = vec3(252.84,-51.62,70.13), Mode = "Register" },
	{ Coords = vec3(250.82,-46.05,70.13), Mode = "Register" },
	{ Coords = vec3(841.06,-1034.74,28.38), Mode = "Register" },
	{ Coords = vec3(845.6,-1030.93,28.38), Mode = "Register" },
	{ Coords = vec3(-330.27,6085.54,31.64), Mode = "Register" },
	{ Coords = vec3(-330.79,6079.63,31.64), Mode = "Register" },
	{ Coords = vec3(-660.93,-934.11,22.02), Mode = "Register" },
	{ Coords = vec3(-665.47,-937.92,22.02), Mode = "Register" },
	{ Coords = vec3(-1304.98,-395.8,36.88), Mode = "Register" },
	{ Coords = vec3(-1307.57,-390.48,36.88), Mode = "Register" },
	{ Coords = vec3(-1117.6,2700.26,18.74), Mode = "Register" },
	{ Coords = vec3(-1118.43,2694.39,18.74), Mode = "Register" },
	{ Coords = vec3(2566.6,293.15,108.92), Mode = "Register" },
	{ Coords = vec3(2571.14,296.97,108.92), Mode = "Register" },
	{ Coords = vec3(-3172.5,1089.41,21.03), Mode = "Register" },
	{ Coords = vec3(-3170.79,1083.74,21.03), Mode = "Register" },
	{ Coords = vec3(23.69,-1106.47,29.98), Mode = "Register" },
	{ Coords = vec3(18.11,-1108.53,29.98), Mode = "Register" },
	{ Coords = vec3(808.87,-2158.49,29.81), Mode = "Register" },
	{ Coords = vec3(813.4,-2154.65,29.81), Mode = "Register" },
	{ Coords = vec3(-821.6,-183.78,37.55), Mode = "Register" },
	{ Coords = vec3(134.06,-1708.19,29.46), Mode = "Register" },
	{ Coords = vec3(-1284.75,-1115.08,7.16), Mode = "Register" },
	{ Coords = vec3(1930.84,3727.52,33.01), Mode = "Register" },
	{ Coords = vec3(1211.07,-470.23,66.39), Mode = "Register" },
	{ Coords = vec3(-30.32,-151.31,57.24), Mode = "Register" },
	{ Coords = vec3(-278.11,6231.06,31.86), Mode = "Register" },
	{ Coords = vec3(78.05,-1388.22,29.51), Mode = "Register" },
	{ Coords = vec3(74.89,-1388.21,29.51), Mode = "Register" },
	{ Coords = vec3(74.53,-1392.08,29.51), Mode = "Register" },
	{ Coords = vec3(-817.02,-1073.53,11.46), Mode = "Register" },
	{ Coords = vec3(-818.58,-1070.79,11.46), Mode = "Register" },
	{ Coords = vec3(-822.11,-1072.41,11.46), Mode = "Register" },
	{ Coords = vec3(-1192.1,-766.32,17.45), Mode = "Register" },
	{ Coords = vec3(-1193.55,-767.4,17.45), Mode = "Register" },
	{ Coords = vec3(-1194.94,-768.44,17.45), Mode = "Register" },
	{ Coords = vec3(-0.42,6511.21,32.01), Mode = "Register" },
	{ Coords = vec3(1.72,6508.89,32.01), Mode = "Register" },
	{ Coords = vec3(4.8,6511.26,32.01), Mode = "Register" },
	{ Coords = vec3(1691.88,4817.84,42.2), Mode = "Register" },
	{ Coords = vec3(1695.0,4818.25,42.2), Mode = "Register" },
	{ Coords = vec3(1694.86,4822.11,42.2), Mode = "Register" },
	{ Coords = vec3(125.83,-225.75,54.69), Mode = "Register" },
	{ Coords = vec3(126.45,-224.05,54.69), Mode = "Register" },
	{ Coords = vec3(127.04,-222.42,54.69), Mode = "Register" },
	{ Coords = vec3(613.4,2764.55,42.22), Mode = "Register" },
	{ Coords = vec3(613.53,2762.75,42.22), Mode = "Register" },
	{ Coords = vec3(613.65,2761.03,42.22), Mode = "Register" },
	{ Coords = vec3(1201.36,2707.57,38.36), Mode = "Register" },
	{ Coords = vec3(1201.35,2710.71,38.36), Mode = "Register" },
	{ Coords = vec3(1197.5,2711.08,38.36), Mode = "Register" },
	{ Coords = vec3(-3170.64,1041.78,21.0), Mode = "Register" },
	{ Coords = vec3(-3169.92,1043.43,21.0), Mode = "Register" },
	{ Coords = vec3(-3169.22,1045.02,21.0), Mode = "Register" },
	{ Coords = vec3(-1096.17,2711.7,19.24), Mode = "Register" },
	{ Coords = vec3(-1098.28,2714.03,19.24), Mode = "Register" },
	{ Coords = vec3(-1101.4,2711.74,19.24), Mode = "Register" },
	{ Coords = vec3(422.91,-810.92,29.62), Mode = "Register" },
	{ Coords = vec3(426.06,-810.9,29.62), Mode = "Register" },
	{ Coords = vec3(426.43,-807.06,29.62), Mode = "Register" },
	{ Coords = vec3(1324.56,-1651.13,52.46), Mode = "Register" },
	{ Coords = vec3(-1152.22,-1424.77,5.14), Mode = "Register" },
	{ Coords = vec3(320.59,181.45,103.78), Mode = "Register" },
	{ Coords = vec3(-3170.94,1073.85,21.02), Mode = "Register" },
	{ Coords = vec3(1861.45,3748.56,33.22), Mode = "Register" },
	{ Coords = vec3(-290.98,6199.91,31.68), Mode = "Register" },
	{ Coords = vec3(241.64,-898.65,29.81), Mode = "Register" },
	{ Coords = vec3(239.44,-897.86,29.81), Mode = "Register" },

	{ Coords = vec3(-905.15,-2781.36,14.33), Mode = "Container" },
	{ Coords = vec3(1178.63,-3126.89,6.22), Mode = "Container" },
	{ Coords = vec3(1178.45,-2996.97,6.11), Mode = "Container" },
	{ Coords = vec3(852.38,-2990.8,6.1), Mode = "Container" },
	{ Coords = vec3(794.37,-3202.89,6.11), Mode = "Container" },
	{ Coords = vec3(496.67,-2968.93,6.23), Mode = "Container" },
	{ Coords = vec3(603.93,-2958.34,6.23), Mode = "Container" },
	{ Coords = vec3(573.04,-2625.16,6.33), Mode = "Container" },
	{ Coords = vec3(315.07,-2674.07,6.19), Mode = "Container" },
	{ Coords = vec3(307.34,-2939.34,6.23), Mode = "Container" },
	{ Coords = vec3(18.0,-2503.34,6.2), Mode = "Container" },
	{ Coords = vec3(-86.18,-2459.67,6.21), Mode = "Container" },
	{ Coords = vec3(-433.92,-2742.91,6.22), Mode = "Container" },
	{ Coords = vec3(-84.15,-2410.03,6.2), Mode = "Container" },
	{ Coords = vec3(208.01,2743.95,43.63), Mode = "Container" },
	{ Coords = vec3(309.92,2900.98,46.57), Mode = "Container" },
	{ Coords = vec3(1445.55,3615.58,34.94), Mode = "Container" },
	{ Coords = vec3(2848.14,4558.16,47.22), Mode = "Container" },
	{ Coords = vec3(2513.92,4995.55,45.23), Mode = "Container" },
	{ Coords = vec3(2358.19,4860.65,41.44), Mode = "Container" },
	{ Coords = vec3(964.3,-3248.86,6.89), Mode = "Container" },
	{ Coords = vec3(1002.17,-3253.41,7.01), Mode = "Container" },
	{ Coords = vec3(1021.95,-3267.5,6.99), Mode = "Container" },
	{ Coords = vec3(1098.74,-3306.02,6.89), Mode = "Container" },
	{ Coords = vec3(1151.78,-3248.26,6.12), Mode = "Container" },
	{ Coords = vec3(1052.38,-3045.11,6.11), Mode = "Container" },
	{ Coords = vec3(1228.79,-2972.04,12.05), Mode = "Container" },
	{ Coords = vec3(838.5,-2923.97,6.1), Mode = "Container" },
	{ Coords = vec3(541.69,-3000.09,6.25), Mode = "Container" },
	{ Coords = vec3(597.49,-2897.4,6.26), Mode = "Container" },
	{ Coords = vec3(631.97,-2958.08,6.27), Mode = "Container" },
	{ Coords = vec3(374.14,-2525.37,6.06), Mode = "Container" },
	{ Coords = vec3(324.61,-2674.36,6.29), Mode = "Container" },
	{ Coords = vec3(251.75,-2734.83,6.03), Mode = "Container" },
	{ Coords = vec3(108.15,-2895.12,6.24), Mode = "Container" },
	{ Coords = vec3(203.61,-2644.34,6.21), Mode = "Container" },
	{ Coords = vec3(-214.94,-2555.2,6.21), Mode = "Container" },
	{ Coords = vec3(-98.76,-2421.16,6.23), Mode = "Container" },
	{ Coords = vec3(74.67,-2496.03,6.22), Mode = "Container" },
	{ Coords = vec3(-44.5,-2240.93,8.02), Mode = "Container" },

	{ Coords = vec3(33.19,-1348.80,29.49), Mode = "Eletronic" },
	{ Coords = vec3(33.19,-1348.80,29.49), Mode = "Eletronic" },
	{ Coords = vec3(2559.05,389.47,108.62), Mode = "Eletronic" },
	{ Coords = vec3(1153.11,-326.90,69.20), Mode = "Eletronic" },
	{ Coords = vec3(-718.26,-915.71,19.21), Mode = "Eletronic" },
	{ Coords = vec3(-57.40,-1751.74,29.42), Mode = "Eletronic" },
	{ Coords = vec3(380.65,322.84,103.56), Mode = "Eletronic" },
	{ Coords = vec3(-3240.02,1008.54,12.83), Mode = "Eletronic" },
	{ Coords = vec3(1735.01,6410.00,35.03), Mode = "Eletronic" },
	{ Coords = vec3(540.22,2671.68,42.15), Mode = "Eletronic" },
	{ Coords = vec3(1968.39,3743.07,32.34), Mode = "Eletronic" },
	{ Coords = vec3(2683.59,3286.30,55.24), Mode = "Eletronic" },
	{ Coords = vec3(1703.31,4934.05,42.06), Mode = "Eletronic" },
	{ Coords = vec3(-1827.68,784.46,138.31), Mode = "Eletronic" },
	{ Coords = vec3(-3040.20,593.29,7.90), Mode = "Eletronic" }
}
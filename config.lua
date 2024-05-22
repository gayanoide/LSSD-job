Config             = {}
Config.SaveDeathStatus	= true -- Save Death Status?

Config.pos = {

	menu = {
		title = 'Los Santos Sheriff Department',

		gps = {
			title = 'L.S.S.D',
			desc = 'Se diriger vers le PDP',
			logo = 'https://i.goopics.net/lrn6yw.png',
			x = 1858.55,
			y = 3678.75,
			z = 33.71,
		},
	},

	accueil = { -- Ped de l'accueil
		position = {x = 1853.49, y = 3689.28, z = 34.28},
		heading = 217.59 -- angle du peds
	},

	boss = { -- Action patron
		position = {x = 1844.48+0.3, y = 3690.04+0.2, z = 34.28},
	},

	annonce = { -- Espace Annonce
		position = {x = 1853.74, y = 3690.95, z = 34.28},
	},

	dispatch = { -- Si tu utilise Rcore_Dispatch sinon voir dans dispatch.lua => ligne 4 pour modifier
		position = {x = 1844.48+0.3, y = 3690.04+0.2, z = 34.28},
	},

	garage = { -- position du menu
		position = {x = 1856.60, y = 3683.95, z = 34.27}, -- position du peds
        heading = 212.86, -- angle du peds

		spawn = {x = 1857.24, y = 3676.74, z = 33.71}, -- position de spawn du vehicule
        angle = 212.94, -- angle de spawn
	},

	vest = { -- Vestiaire
		position = {x = 1862.80, y = 3689.65, z = 34.31},
	},

	armory = { -- Ped
		position = {x = 1848.21, y = 3694.82, z = 34.28},
		heading = 256.97 -- angle du peds
	},

	message = { -- Ped
		position = {x = 1855.00, y = 3683.54, z = 34.88},
		texte = "Poste de Sheriff",
		distance = 10
	},
	
	coffre = { 
		position = {x = 1851.16, y = 3693.39, z = 34.28},			
		poids = 10,
	},










	-- Assenceur
	
	tp00 = { -- Bouton
		label = "Niveau Helipad",
		position = {x = -317.00+0.5, y = -279.61, z = 43.24},
	},	
	tp0 = { -- Spawn
		position = {x = -316.92, y = -279.61, z = 43.24},
		heading = 51.42
	},
	
	tp01 = { -- Bouton
		label = "Niveau Presse",
		position = {x = -359.00+0.1, y = -257.68+0.3, z = 39.77+0.5},
	},	
	tp1 = { -- Spawn
		position = {x = -357.86, y = -257.88, z = 39.74},
		heading = 320.81
	},

	
	tp02 = { -- Bouton
		label = "Niveau Accueil",
		position = {x = -359.00+0.1, y = -257.68+0.3, z = 36.57},
	},	
	tp2 = { -- Spawn
		position = {x = -357.86, y = -257.88, z = 36.07},
		heading = 327.51
	},

	
	tp03 = { -- Bouton
		label = "Niveau Garage",
		position = {x = -359.00+0.1, y = -257.68+0.3, z = 32.80},
	},	
	tp3 = { -- Spawn
		position = {x = -357.86, y = -257.88, z = 32.30},
		heading = 323.85
	},
	
}

ShowRange = 5000
DoorLock = true
carInvincible = true 

Cars = {
    {
        pos = vec(-370.65, -233.83, 35.90),
        heading = 92.67,
        model = 'police3',
        spin = false,
        --text = "Cliffhanger \n Prix :~y~10'000'000 $",
        plate = "lssd"
    },
}
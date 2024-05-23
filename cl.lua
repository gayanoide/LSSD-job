
local isDead, isBusy = false, false
local dragStatus = {}
dragStatus.isDragged = false
local isHandcuffed = false

ESX = exports["es_extended"]:getSharedObject()
local PlayerData = {}

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
        PlayerData.job = job
        Citizen.Wait(5000)
end)
RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
        PlayerData.job2 = job2
        Citizen.Wait(5000)
end)
Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj)
                ESX = obj
        end)
        Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job2 == nil do
            Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then
            ESX.PlayerData = ESX.GetPlayerData()
    end
end)
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        ESX.PlayerData = xPlayer
end)
    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        ESX.PlayerData.job = job
end)
    RegisterNetEvent('esx:setJob2')
    AddEventHandler('esx:setJob2', function(job2)
        ESX.PlayerData.job2 = job2
end)

local disablecontrol = false
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
	    if disablecontrol then
	    	FreezeEntityPosition(PlayerPedId(), true)
		else
			FreezeEntityPosition(PlayerPedId(), false)
		end
	end
end)


RegisterKeyMapping('Emylssd', 'Ouvrir le menu L.S.P.D', 'keyboard', 'F6')












RegisterCommand('Emylssd', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'lssd' then
        exports.ox_lib:showContext('lssdmenu')    
	end
end)

exports.ox_lib:registerContext({
    id = 'lssdmenu',
    --title = Config.pos.Menu.titre,
    title = Config.pos.menu.title,
    options = {
      {
        title = Config.pos.menu.gps.title,
        description = Config.pos.menu.gps.desc,
        image = Config.pos.menu.gps.logo,
        progress = '100',      
        onSelect = function()
            --ESX.ShowNotification("~y~ca fonctionne")
            SetNewWaypoint(vector3(Config.pos.menu.gps.x, Config.pos.menu.gps.y, Config.pos.menu.gps.z))
        end,
      },      
      {
        title = 'Menu Interaction',
        description = 'Interagir avec un citoyen',
        menu = 'intermenulssd',
      },   
      {
        title = 'Emotes rapide',
        description = 'Faire une emote',
        menu = 'emotelssdmenu',
      },   
      {
        title = 'Les Droit Miranda',
        description = 'Un trou  de memoire, et je suis la',      
        onSelect = function() 

            ESX.ShowNotification("~y~Monsieur / Madame (Prénom et nom de la personne), je vous arrête pour (motif de l'arrestation).", "info", 10000)
            Citizen.Wait(10000)
            ESX.ShowNotification("~y~Vous avez le droit de garder le silence.", "info", 5000)
            Citizen.Wait(5000)
            ESX.ShowNotification("~y~Si vous renoncez à ce droit, tout ce que vous direz pourra être et sera utilisé contre vous.", "info", 5000)
            Citizen.Wait(5000)
            ESX.ShowNotification("~y~Vous avez le droit à un avocat, si vous n’en avez pas les moyens, un avocat vous sera fourni.", "info", 5000)
            Citizen.Wait(5000)
            ESX.ShowNotification("~y~Vous avez le droit à une assistance médicale ainsi qu'à de la nourriture et de l'eau.", "info", 5000)
            Citizen.Wait(5000)
            ESX.ShowNotification("~y~Avez-vous bien compris vos droits ?")
        end,
      },
    }
})

exports.ox_lib:registerContext({
    id = 'intermenulssd',
    title = 'Interaction',
    menu = 'some_menu',
    onBack = function()
        exports.ox_lib:showContext('lssdmenu') 
    end,
    options = {
        {
          title = 'Menotter / demenotter', 
          description = 'Mettre en etat d\'arrestation un citoyen',
          onSelect = function()
            --ESX.ShowNotification("~y~ca fonctionne")
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer() 
                       
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent('lssd:handcuff', GetPlayerServerId(closestPlayer))
                TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8.0, -1, 33, 0.0, false, false, false)
                Citizen.Wait(3500)
                ClearPedTasks(PlayerPedId())
            end
          end,
        },
        {
          title = 'Fouiller', 
          description = 'Faire une fouille de la personne',
          onSelect = function()
            --ESX.ShowNotification("~y~ca fonctionne")
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                exports.ox_inventory:openInventory('player', GetPlayerServerId(closestPlayer))
            end
          end,
        },
        {
          title = 'Escorter', 
          description = 'Escorter de force l\'individu',
          onSelect = function()
            --ESX.ShowNotification("~y~ca fonctionne")
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()            
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent('lssd:drag', GetPlayerServerId(closestPlayer))
            end
          end,
        },
        {
          title = 'Donner le PPA', 
          description = 'La personne a reussi le test et vous lui donner la license',
          onSelect = function()
            ESX.ShowNotification("~y~ca fonctionne")
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                exports["WaveShield"]:TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'weapon')
                TriggerServerEvent('add:addlic')
                ESX.ShowNotification('Le joueur a bien reçu son PPA')
            else
                ESX.ShowNotification('Aucun joueurs à proximité')
            end
          end,
        },
        {
          title = 'Mettre dans le vehicule', 
          description = 'Mettre la personne du vehicule',
          onSelect = function()
                ESX.ShowNotification("~y~ca fonctionne")
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
					TriggerServerEvent('lssd:putInVehicle', GetPlayerServerId(closestPlayer))
                else
                    ESX.ShowNotification('Aucune personne proche')
                end
          end,
        },
        {
          title = 'Sortir du vehicule', 
          description = 'sortir la personne du vehicule',
          onSelect = function()
                ESX.ShowNotification("~y~ca fonctionne")
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    TriggerServerEvent('lssd:OutVehicle', GetPlayerServerId(closestPlayer))
                else
                    ESX.ShowNotification('Aucune personne proche')
                end
          end,
        },
        {
          title = 'Faire une facture', 
          description = 'Faire une facture custom',
          onSelect = function()
              ESX.ShowNotification("~y~ca fonctionne")

                OpenBillingMenu() 

          end,
        },
    }
})


exports.ox_lib:registerContext({
    id = 'emotelssdmenu',
    title = 'Emotes rapide',
    menu = 'some_menu',
    onBack = function()
        exports.ox_lib:showContext('lssdmenu') 
    end,
    options = {
        {
          title = 'Saluer', 
          description = ' ',
          onSelect = function()
              --ESX.ShowNotification("~y~ca fonctionne")
              ExecuteCommand('e salute')
          end,
        },
        {
          title = 'repos', 
          description = ' ',
          onSelect = function()
              --ESX.ShowNotification("~y~ca fonctionne")
              ExecuteCommand('e valet3')
          end,
        },
        {
          title = 'Faire la circulation', 
          description = ' ',
          onSelect = function()
              --ESX.ShowNotification("~y~ca fonctionne")
              ExecuteCommand('e copbeacon')
          end,
        },
        {
          title = 'Main sur l\'arme', 
          description = ' ',
          onSelect = function()
              --ESX.ShowNotification("~y~ca fonctionne")
              ExecuteCommand('e holster')
          end,
        },
        {
          title = 'Sortir la lampe', 
          description = ' ',
          onSelect = function()
              --ESX.ShowNotification("~y~ca fonctionne")
              ExecuteCommand('e holster8')
          end,
        },
        {
          title = 'Montrer son badge', 
          description = ' ',
          onSelect = function()
              --ESX.ShowNotification("~y~ca fonctionne")
              ExecuteCommand('e idcardh')
          end,
        },
        {
          title = 'Annuler l\'emote', 
          description = ' ',
          onSelect = function()
              --ESX.ShowNotification("~y~ca fonctionne")
				ExecuteCommand('emotecancel')
				ClearPedTasks(GetPlayerPed(-1))
          end,
        },
    }
})



























-- Assenceur

exports.ox_lib:registerContext({
    id = 'tplssd',
    title = 'Assenceur',
    options = {
        {
            title = Config.pos.tp00.label,
            progress = '100',
            onSelect = function()
                --ESX.ShowNotification("~y~ca fonctionne")                
                DoScreenFadeOut(1000)
                Wait(1000)
                FreezeEntityPosition(PlayerPedId(), true)
                tp(Config.pos.tp0.position.x, Config.pos.tp0.position.y, Config.pos.tp0.position.z)
                SetEntityHeading(PlayerPedId(), Config.pos.tp0.heading)
                FreezeEntityPosition(PlayerPedId(), false)
                Wait(900)
                DoScreenFadeIn(1000)                           
            end,
        },
        {
            title = Config.pos.tp01.label,
            progress = '100',
            onSelect = function()
                --ESX.ShowNotification("~y~ca fonctionne")                
                DoScreenFadeOut(1000)
                Wait(1000)
                FreezeEntityPosition(PlayerPedId(), true)
                tp(Config.pos.tp1.position.x, Config.pos.tp1.position.y, Config.pos.tp1.position.z)
                SetEntityHeading(PlayerPedId(), Config.pos.tp1.heading)
                FreezeEntityPosition(PlayerPedId(), false)
                Wait(900)
                DoScreenFadeIn(1000)                           
            end,
        },
        {
            title = Config.pos.tp02.label,
            progress = '100',
            onSelect = function()                
                --ESX.ShowNotification("~y~ca fonctionne")                
                DoScreenFadeOut(1000)
                Wait(1000)
                FreezeEntityPosition(PlayerPedId(), true)
                tp(Config.pos.tp2.position.x, Config.pos.tp2.position.y, Config.pos.tp2.position.z)
                SetEntityHeading(PlayerPedId(), Config.pos.tp2.heading)
                FreezeEntityPosition(PlayerPedId(), false)
                Wait(900)
                DoScreenFadeIn(1000)
            end,
        },
        {
            title = Config.pos.tp03.label,
            progress = '100',
            onSelect = function()
                --ESX.ShowNotification("~y~ca fonctionne")                
                DoScreenFadeOut(1000)
                Wait(1000)
                FreezeEntityPosition(PlayerPedId(), true)
                tp(Config.pos.tp3.position.x, Config.pos.tp3.position.y, Config.pos.tp3.position.z)
                SetEntityHeading(PlayerPedId(), Config.pos.tp3.heading)
                FreezeEntityPosition(PlayerPedId(), false)
                Wait(900)
                DoScreenFadeIn(1000)
            end,
        },
    },
})

function tp(x,y,z)
	SetEntityCoords(PlayerPedId(), x, y, z - 0.9)
end

RegisterNetEvent('tp:openmenu')
AddEventHandler('tp:openmenu', function()
    exports.ox_lib:showContext('tplssd')
end)

-- Niveau 0

exports.ox_target:addBoxZone(
    {
        coords = vec3(Config.pos.tp00.position.x, Config.pos.tp00.position.y, Config.pos.tp00.position.z),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'poly',
                event = 'tp:openmenu',
                icon = 'fa-solid fa-cube',
                label = 'Appeler un assenceur',
            },
        },
        minZ = Config.pos.tp00.position.z - 0.3,
        maxZ = Config.pos.tp00.position.z + 0.3,
    }
)

exports.ox_target:addBoxZone(
    {
        coords = vec3(Config.pos.tp01.position.x, Config.pos.tp01.position.y, Config.pos.tp01.position.z),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'poly',
                event = 'tp:openmenu',
                icon = 'fa-solid fa-cube',
                label = 'Appeler un assenceur',
            },
        },
        minZ = Config.pos.tp01.position.z - 0.3,
        maxZ = Config.pos.tp01.position.z + 0.3,
    }
)

-- Niveau 1

exports.ox_target:addBoxZone(
    {
        coords = vec3(Config.pos.tp02.position.x, Config.pos.tp02.position.y, Config.pos.tp02.position.z),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'poly',
                event = 'tp:openmenu',
                icon = 'fa-solid fa-cube',
                label = 'Appeler un assenceur',
            },
        },
        minZ = Config.pos.tp02.position.z - 0.3,
        maxZ = Config.pos.tp02.position.z + 0.3,
    }
)

-- Niveau 2

exports.ox_target:addBoxZone(
    {
        coords = vec3(Config.pos.tp03.position.x, Config.pos.tp03.position.y, Config.pos.tp03.position.z),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'poly',
                event = 'tp:openmenu',
                icon = 'fa-solid fa-cube',
                label = 'Appeler un assenceur',
            },
        },
        minZ = Config.pos.tp03.position.z - 0.3,
        maxZ = Config.pos.tp03.position.z + 0.3,
    }
)














-------  Menu Annonces

exports.ox_lib:registerContext({
    id = 'annoncemenu',
    title = 'Faire une annonce',
    options = {
        {
            title = 'Ouvert',
            progress = '100',
            onSelect = function()
                --ESX.ShowNotification("~y~ca fonctionne")  				
				--exports["WaveShield"]:TriggerServerEvent('htaxi:Ouvert')
				TriggerServerEvent('hlssd:Ouvert')
                ESX.ShowNotification("~y~open")    
            end,
        },
        {
            title = 'Fermer',
            progress = '100',
            onSelect = function()
                --ESX.ShowNotification("~y~ca fonctionne") 
                --exports["WaveShield"]:TriggerServerEvent('htaxi:Fermer') 
                TriggerServerEvent('hlssd:Fermer') 
                ESX.ShowNotification("~y~close") 
            end,
        },
    },
})

RegisterNetEvent('lssd:annonce')
AddEventHandler('lssd:annonce', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'lssd' then
       	exports.ox_lib:showContext('annoncemenu')
	else
		ESX.ShowNotification("~y~ta pas acces miskin")
	end
end)

exports.ox_target:addBoxZone(
	{
        coords = vec3(Config.pos.annonce.position.x, Config.pos.annonce.position.y, Config.pos.annonce.position.z),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'poly',
                event = 'lssd:annonce',
                icon = 'fa-solid fa-cube',
                label = 'Acceder a l\'ordinateur',
            },
        },
        minZ = Config.pos.annonce.position.z - 0.3,
        maxZ = Config.pos.annonce.position.z + 0.3,
    }
)










Citizen.CreateThread(function()
    local hash = GetHashKey("mp_f_execpa_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVMALE", "mp_f_execpa_01", Config.pos.armory.position.x, Config.pos.armory.position.y, Config.pos.armory.position.z-0.99, Config.pos.armory.heading, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    --TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BUM_BIN', 0, true)
end)

exports.ox_target:addBoxZone(
	{
        coords = vec3(Config.pos.armory.position.x, Config.pos.armory.position.y, Config.pos.armory.position.z),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'poly',
                event = 'lssd:armory',
                icon = 'fa-solid fa-cube',
                label = 'Acceder a l\'armurerie',
            },
        },
        minZ = Config.pos.armory.position.z - 0.3,
        maxZ = Config.pos.armory.position.z + 0.3,
    }
)

RegisterNetEvent('lssd:armory')
AddEventHandler('lssd:armory', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'lssd' then
       	exports.ox_lib:showContext('armorymenu')
	else
		ESX.ShowNotification("~y~ta pas acces miskin")
	end
end)

exports.ox_lib:registerContext({
    id = 'armorymenu',
    title = 'Armurerie',
    options = {
        {
            title = 'Prendre son equipement',
            progress = '100',
            onSelect = function()
                --ESX.ShowNotification("~y~ca fonctionne")  				
				--exports["WaveShield"]:TriggerServerEvent('hlssd:addarmes')
				TriggerServerEvent('hlssd:addarmes')
                --ESX.ShowNotification("~y~Vous avez pris votre equipement")    
            end,
        },
        {
            title = 'Rendre son equipement',
            progress = '100',
            onSelect = function()
                --ESX.ShowNotification("~y~ca fonctionne") 
                --exports["WaveShield"]:TriggerServerEvent('hlssd:rendarmes') 
                TriggerServerEvent('hlssd:rendarmes') 
                --ESX.ShowNotification("~y~Vous avez rendu votre equipement") 
            end,
        },
    },
})

RegisterNetEvent('lssd:handcuff')
AddEventHandler('lssd:handcuff', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	if isHandcuffed then
		
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(5)
		end
		
		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetPedCanPlayGestureAnims(playerPed, false)

		if Config.EnableHandcuffTimer then
			if handcuffTimer.active then
				ESX.ClearTimeout(handcuffTimer.task)
			end

			--StartHandcuffTimer()
		end
	else
		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 56, true) -- F9
			DisableControlAction(0, 75, true)
			DisableControlAction(0, 145, true)
			DisableControlAction(0, 185, true)
			DisableControlAction(0, 49, true)
			DisableControlAction(1, 75, true)
			DisableControlAction(1, 57, true)
			DisableControlAction(1, 145, true)
			DisableControlAction(1, 185, true)
			DisableControlAction(1, 49, true)
			DisableControlAction(0, 232, true)
			DisableControlAction(0, 236, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 29, true)
			DisableControlAction(0, 58, true)
			DisableControlAction(0, 113, true)
			DisableControlAction(0, 183, true)
			DisableControlAction(0, 47, true)
			DisableControlAction(0, 79, true)
			DisableControlAction(0, 253, true)
			DisableControlAction(0, 324, true)
			DisableControlAction(0, 144, true)
			DisableControlAction(0, 145, true)
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 102, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 75, true) -- Disable pause screen
			DisableControlAction(0, 288, true) -- Cover
			DisableControlAction(0, 299, true) -- Select Weapon
			DisableControlAction(0, 170, true) -- F2
			DisableControlAction(0, 168, true) -- F6
			DisableControlAction(0, 166, true) -- Disable changing view
			DisableControlAction(0, 167, true) -- Disable looking behind
			DisableControlAction(0, 204, true) -- Disable clearing animation
			DisableControlAction(2, 211, true) -- Disable pause screen
			DisableControlAction(0, 192, true) -- Disable pause screen
			DisableControlAction(0, 10, true) -- Disable pause screen
			DisableControlAction(0, 11, true) -- Disable pause screen
			DisableControlAction(0, 47, true) -- Disable pause screen
			DisableControlAction(0, 167, true) -- Disable looking behind
			DisableControlAction(0, 204, true) -- Disable clearing animation
			DisableControlAction(2, 211, true) -- Disable pause screen
			DisableControlAction(0, 192, true) -- Disable pause screen
			DisableControlAction(0, 10, true) -- Disable pause screen
			DisableControlAction(0, 11, true) -- Disable pause screen
			DisableControlAction(0, 47, true) -- Disable pause screen
			DisableControlAction(0, 157, true) -- Disable clearing animation
			DisableControlAction(2, 158, true) -- Disable pause screen
			DisableControlAction(0, 159, true) -- Disable pause screen
			DisableControlAction(0, 160, true) -- Disable pause screen
			DisableControlAction(0, 161, true) -- Disable pause screen
			DisableControlAction(0, 121, true) -- Disable pause screen
			DisableControlAction(0, 137, true) -- Disable pause screen
			DisableControlAction(0, 132, true) -- Disable pause screen
			DisableControlAction(0, 121, true) -- Disable pause screen
			DisableControlAction(0, 121, true) -- Disable pause screen
			DisableControlAction(0, 157, true) -- Disable pause screen
			DisableControlAction(0, 158, true) -- Disable pause screen
			DisableControlAction(0, 160, true) -- Disable pause screen
			DisableControlAction(0, 164, true) -- Disable pause screen
			DisableControlAction(0, 165, true) -- Disable pause screen
			DisableControlAction(0, 289, true) -- Disable pause screen
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(5)
		end
	end
end)



RegisterNetEvent('lssd:putInVehicle')
AddEventHandler('lssd:putInVehicle', function()
    local plyPed = PlayerPedId()
	local coords = GetEntityCoords(plyPed, false)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i = maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				dragStatus.isDragged = false
				DetachEntity(plyPed, true, false)
				TaskWarpPedIntoVehicle(plyPed, vehicle, freeSeat)
			end
		end
	end
end)

RegisterNetEvent('lssd:OutVehicle')
AddEventHandler('lssd:OutVehicle', function()
    local plyPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(plyPed) then
		return
	end

	dragStatus.isDragged = false
	DetachEntity(plyPed, true, false)
	local vehicle = GetVehiclePedIsIn(plyPed, false)
	TaskLeaveVehicle(plyPed, vehicle, 10)
end)

RegisterNetEvent('lssd:drag')
AddEventHandler('lssd:drag', function(copId)
	if isHandcuffed then
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)

CreateThread(function()
	local wasDragged

	while true do
		local Sleep = 2

		if isHandcuffed and dragStatus.isDragged then
			Sleep = 3
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(PlayerPedId(), targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Wait(3)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(PlayerPedId(), true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(PlayerPedId(), true, false)
		end
	Wait(Sleep)
	end
end)












function OpenBillingMenu()
    local playerPed = PlayerPedId()
    local player, distance = ESX.Game.GetClosestPlayer()

    
    --print("Player: ", player, " Distance: ", distance) -- Debugging line

    if player ~= -1 and distance <= 3.0 then
        local target = GetPlayerServerId(player)
        --print("Avant d'ouvrir le dialogue") -- Debugging line

        local input = exports.ox_lib:inputDialog('Amende L.S.S.D', {
            { type = 'number', label = 'Montant', placeholder = 'Montant de la facture' }
        })
        --print("Après avoir tenté d'ouvrir le dialogue") -- Debugging line

        if input then
            local amount = tonumber(input[1])

            if amount then
                TriggerServerEvent('esx_billing:sendBill', target, 'society_lssd', 'Amende '..Config.pos.menu.title, amount)
                ESX.ShowNotification('Facture envoyer')
            else
                ESX.ShowNotification('Informations de la facture incorrectes')
            end
        else
            ESX.ShowNotification('Facturation annulée')
        end
    else
        ESX.ShowNotification('Aucun joueur à proximité')
    end
end
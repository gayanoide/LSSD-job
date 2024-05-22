ESX = exports["es_extended"]:getSharedObject()
local deadPlayers = {}









RegisterServerEvent('hlssd:Ouvert')
AddEventHandler('hlssd:Ouvert', function()
--exports["WaveShield"]:AddEventHandler('hlssd:Ouvert', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent("k5_notify:notify", xPlayers[i], 'L.S.P.D', 'La permanance est OUVERT', 'lssd', 10000)
	end
end)


RegisterServerEvent('hlssd:Fermer')
AddEventHandler('hlssd:Fermer', function()
--exports["WaveShield"]:AddEventHandler('hlssd:Fermer', function(source)
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
local xPlayers	= ESX.GetPlayers()
for i=1, #xPlayers, 1 do
	local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	TriggerClientEvent("k5_notify:notify", xPlayers[i], 'L.S.P.D', 'La permanance est FERMER', 'lssd', 10000)
end
end)

RegisterServerEvent('hlssd:addarmes')
AddEventHandler('hlssd:addarmes', function()
--exports["WaveShield"]:AddEventHandler('hlssd:addarmes', function(source)
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local identifier
	local steam
	local playerId = source
	local PcName = GetPlayerName(playerId)
	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
			break
		end
	end
	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'steam:') then
			steam = string.sub(v, 7)
			break
		end
	end

xPlayer.addInventoryItem('WEAPON_NIGHTSTICK', 1)
xPlayer.addInventoryItem('WEAPON_STUNGUN', 1)
xPlayer.addInventoryItem('WEAPON_FLASHLIGHT', 1)
end)

RegisterNetEvent('hlssd:rendarmes')
AddEventHandler('hlssd:rendarmes', function(arme, prix)
--exports["WaveShield"]:AddEventHandler('hlssd:rendarmes', function(source)
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local identifier
	local steam
	local playerId = source
	local PcName = GetPlayerName(playerId)
	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
			break
		end
	end
	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'steam:') then
			steam = string.sub(v, 7)
			break
		end
	end

xPlayer.removeInventoryItem('WEAPON_NIGHTSTICK', 1)
xPlayer.removeInventoryItem('WEAPON_STUNGUN', 1)
xPlayer.removeInventoryItem('WEAPON_FLASHLIGHT', 1)
end)

RegisterNetEvent('lssd:handcuff')
AddEventHandler('lssd:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'lssd' or xPlayer.job2.name == 'lssd' then
		TriggerClientEvent('lssd:handcuff', target)
	else
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit Handcuffs!'):format(xPlayer.source))
	end
end)

RegisterNetEvent('lssd:search')
AddEventHandler('lssd:search', function(playerId)
    local src = source
    local target = ESX.GetPlayerFromId(playerId)

    if target then
        -- Utilisation de ox_inventory pour montrer l'inventaire
        exports.ox_inventory:openInventory('player', target.source)
        TriggerClientEvent('esx:showNotification', src, 'Vous avez fouillé la personne')
        TriggerClientEvent('esx:showNotification', target.source, 'Vous êtes fouillé par la lssd')
    end
end)

RegisterNetEvent('lssd:giveLicense')
AddEventHandler('lssd:giveLicense', function(playerId, licenseType)
    local src = source
    local target = ESX.GetPlayerFromId(playerId)

    if target then
        MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
            ['@type'] = licenseType,
            ['@owner'] = target.identifier
        }, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('esx:showNotification', src, 'Vous avez donné une licence')
                TriggerClientEvent('esx:showNotification', target.source, 'Vous avez reçu une licence')
            else
                TriggerClientEvent('esx:showNotification', src, 'Erreur lors de l\'ajout de la licence')
            end
        end)
    end
end)



RegisterNetEvent('lssd:putInVehicle')
AddEventHandler('lssd:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('lssd:putInVehicle', target)
end)

RegisterNetEvent('lssd:OutVehicle')
AddEventHandler('lssd:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('lssd:OutVehicle', target)
end)



RegisterServerEvent('add:addlic')
AddEventHandler('add:addlic', function(playerId, permis)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do

		local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer2.source == playerId then
			TriggerEvent('esx_license:addLicense', xPlayer2.source, permis)
			TriggerClientEvent('esx:showNotification', xPlayers.source, "Vous avez bien reçu le PPA")
		end
	end
end)
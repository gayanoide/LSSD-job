RegisterCommand("appelerlssd", function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    -- Vérifier si le joueur a les permissions nécessaires pour appeler la lssd
    -- Vous pouvez ajuster ou supprimer cette vérification si vous le souhaitez
    
    -- Récupérer les joueurs de la lssd
    local lssdPlayers = ESX.GetPlayers()

    for _, player in ipairs(lssdPlayers) do
        local xPlayer = ESX.GetPlayerFromId(player)
        if xPlayer.job.name == "lssd" then -- Assurez-vous que "lssd" correspond au nom du job de la lssd
            -- Envoyer un message à chaque joueur de la lssd
            TriggerClientEvent("k5_notify:notify", player, 'L.S.P.D', 'Un agent est appelé l\'accueil !', 'lssd', 10000)
        end
    end
end, false)
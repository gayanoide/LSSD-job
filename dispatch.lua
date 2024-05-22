RegisterNetEvent('lssd:dispatchmenu')
AddEventHandler('lssd:dispatchmenu', function(type, data)
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'lssd' then
        ExecuteCommand('panel')
    else
        ESX.ShowNotification("~y~ta pas acces miskin")
    end
end)

exports.ox_target:addBoxZone(
    {
        coords = vec3(Config.pos.dispatch.position.x, Config.pos.dispatch.position.y, Config.pos.dispatch.position.z),
        size = vec3(1, 1, 1),
        rotation = 0,
        debug = drawZones,
        options = {
            {
                name = 'box',
                event = 'lssd:dispatchmenu',
                icon = 'fa-solid fa-cube',
                label = 'Acceder au Dispatch',
            },
        },
        minZ = Config.pos.dispatch.position.z - 0.3,
        maxZ = Config.pos.dispatch.position.z + 0.3,
    }
)
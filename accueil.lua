


exports.ox_target:addBoxZone(
    {
        coords = vec3(Config.pos.accueil.position.x, Config.pos.accueil.position.y, Config.pos.accueil.position.z),
        size = vec3(1, 1, 1),
        rotation = 0,
        debug = drawZones,
        options = {
            {
                name = 'box',
                event = 'appelerlssd',
                icon = 'fa-solid fa-cube',
                label = 'Demander un Agent',
            },
        },
        minZ = Config.pos.accueil.position.z - 0.3,
        maxZ = Config.pos.accueil.position.z + 0.3,
    }
)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_f_execpa_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVMALE", "mp_f_execpa_01", Config.pos.accueil.position.x, Config.pos.accueil.position.y, Config.pos.accueil.position.z-0.99, Config.pos.accueil.heading, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    --TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BUM_BIN', 0, true)
end)

RegisterNetEvent('appelerlssd')
AddEventHandler('appelerlssd', function(type, data)
    ExecuteCommand("appelerlssd")
end)
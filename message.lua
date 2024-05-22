
local textscreens = {
    {
        coords = vector3(Config.pos.message.position.x, Config.pos.message.position.y, Config.pos.message.position.z + 1.1),
        text = Config.pos.message.texte,
        size = 1.0,
        font = 1,
        maxDistance = Config.pos.message.distance
    },
}






Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

        for i = 1, #textscreens do
            local distance = #(plyCoords - textscreens[i].coords)
            if distance < textscreens[i].maxDistance then
                ESX.Game.Utils.DrawText3D(textscreens[i].coords, textscreens[i].text, textscreens[i].size, textscreens[i].font)
            end
        end
    end
end)

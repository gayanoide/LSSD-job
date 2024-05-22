fx_version 'adamant'
this_is_a_map 'yes'

game 'gta5'


client_scripts {
    '@es_extended/locale.lua',

    'cl.lua',
    'clboss.lua',
    'message.lua',
    'dispatch.lua',
    'garage.lua',
    'vest.lua',
    'show.lua',
    'accueil.lua',
    'coffre.lua',
}

server_scripts {
    '@es_extended/locale.lua',
    '@oxmysql/lib/MySQL.lua',
    
    'sv.lua',
    'sv_accueil.lua',
}

shared_scripts {
    '@es_extended/imports.lua',
    '@es_extended/locale.lua',

    'config.lua',
}
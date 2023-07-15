fx_version 'adamant'
game 'gta5'
lua54 'yes'





author 'SpookyAnti'
description 'Simple pawnshop script using ox_lib context menu. You can sell or buy items.'
version '1.0'






shared_scripts{
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

files {
    'locales/*.json'
}

client_scripts{
    'config.lua',
    'client/main.lua',
}

server_scripts{
    'server/main.lua',
    'config.lua'
}
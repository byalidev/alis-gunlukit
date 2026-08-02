fx_version 'cerulean'
game 'gta5'

description 'Standalone Daily Kit for Ox Inventory'
version '1.0.0'

-- ox_lib bildirimleri kullanmak için (isteğe bağlı ama önerilir)
shared_script '@ox_lib/init.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
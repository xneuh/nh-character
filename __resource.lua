fx_version 'adamant'

lua54 'yes'

game 'gta5'


server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'nh_cfg.lua',
	'server/*.lua'
}

client_scripts {
	'nh_cfg.lua',
	'client/nh_cl.lua',
}
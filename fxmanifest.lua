resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"
fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
games {"rdr3"}

client_scripts {
    'client/client.lua',
	'client/mp_male.lua',
	'client/mp_female.lua',
    'client/mp_malebarba.lua',
    'config.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}

fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/config/Native.lua",
	"client-side/*"
}

server_scripts {
	"server-side/*"
}

files {
	"web-side/*"
}

shared_scripts {
	"@vrp/lib/Utils.lua",
	"@vrp/config/Vehicle.lua",
	"@vrp/config/Global.lua"
}
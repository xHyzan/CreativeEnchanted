fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

client_scripts {
	"client-side/*"
}

shared_scripts {
    "shared-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}
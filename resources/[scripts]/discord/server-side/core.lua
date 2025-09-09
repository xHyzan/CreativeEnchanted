-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Avatar = {}
local DiscordToken = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
local Discord = {
	Connect = "",
	Disconnect = "",
	Airport = "",
	Deaths = "",
	Gemstone = "",
	Rename = "",
	Roles = "",
	Hackers = "",
	Skin = "",
	ClearInv = "",
	Dima = "",
	God = "",
	Item = "",
	Delete = "",
	Kick = "",
	Ban = "",
	Group = "",
	AddCar = "",
	Print = "",
	Permissions = "",
	Sprays = "",
	Pdm = "",
	Vehicles = "",
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMBED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Embed",function(Hook,Message,source)
	PerformHttpRequest(Discord[Hook],function() end,"POST",json.encode({
		username = ServerName,
		avatar_url = ServerAvatar,
		embeds = {
			{
				color = 6171009,
				description = Message,
				footer = {
					icon_url = ServerAvatar,
					text = os.date("%d/%m/%Y %H:%M:%S")
				}
			}
		}
	}),{ ["Content-Type"] = "application/json" })

	if source then
		TriggerClientEvent("megazord:Screenshot",source,Discord[Hook])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTENT
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Content",function(Hook,Message)
	PerformHttpRequest(Discord[Hook],function() end,"POST",json.encode({
		username = ServerName,
		content = Message
	}),{ ["Content-Type"] = "application/json" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Webhook",function(Hook)
	return Discord[Hook] or ""
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVATAR
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Avatar",function(Passport)
	return Avatar[Passport]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	local Consult = vRP.AccountInformation(Passport,"Discord")
	if Passport and Consult and Consult ~= 0 then
		PerformHttpRequest("https://discord.com/api/users/"..Consult,function(Return,Response)
			if Return == 200 then
				local Result = json.decode(Response)
				if Result and Result.avatar then
					Avatar[Passport] = "https://cdn.discordapp.com/avatars/"..Consult.."/"..Result.avatar..".png"
				end
			end
		end,"GET","",{ Authorization = "Bot "..DiscordToken })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Avatar[Passport] then
		Avatar[Passport] = nil
	end
end)
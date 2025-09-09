-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("keyboard",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Form = {}
local Results = false
local Progress = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUCESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Success",function(Data,Callback)
	SetNuiFocus(false,false)
	Results = Data.Inputs
	Progress = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	Results = false
	Progress = false
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYBOARD
-----------------------------------------------------------------------------------------------------------------------------------------
function Keyboard(Rows,Title,Subtitle)
	if Progress then
		return false
	end

	Results = {}
	Progress = true
	SetNuiFocus(true,true)
	SetCursorLocation(0.5,0.5)

	SendNUIMessage({
		Action = "Open",
		Payload = {
			Rows = Rows,
			Title = Title or "Formulário",
			Subtitle = Subtitle or "Preencha os campos abaixo"
		}
	})

	while Progress do
		Wait(0)
	end

	if not Results or #Results == 0 then
		return false
	end

	for _,v in ipairs(Results) do
		if v == "" or v == nil then
			return false
		end
	end

	return Results
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSWORD
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Password = function(Placeholder)
	return Keyboard({
		{ Mode = "password", Placeholder = Placeholder }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRIMARY
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Primary = function(First)
	return Keyboard({
		{ Mode = "text", Placeholder = First }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SECONDARY
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Secondary = function(First,Second)
	return Keyboard({
		{ Mode = "text", Placeholder = First },
		{ Mode = "text", Placeholder = Second }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TERTIARY
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Tertiary = function(First,Second,Third)
	return Keyboard({
		{ Mode = "text", Placeholder = First },
		{ Mode = "text", Placeholder = Second },
		{ Mode = "text", Placeholder = Third }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUATERNARY
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Quaternary = function(First,Second,Third,Fourth)
	return Keyboard({
		{ Mode = "text", Placeholder = First },
		{ Mode = "text", Placeholder = Second },
		{ Mode = "text", Placeholder = Third },
		{ Mode = "area", Placeholder = Fourth }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNED
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Banned = function(First,Second,Third,Fourth)
	return Keyboard({
		{ Mode = "text", Placeholder = First },
		{ Mode = "text", Placeholder = Second },
		{ Mode = "options", Placeholder = "Selecione uma opção", Options = Third },
		{ Mode = "text", Placeholder = Fourth }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AREA
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Area = function(First)
	return Keyboard({
		{ Mode = "area", Placeholder = First }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COPY
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Copy = function(First,Message)
	return Keyboard({
		{ Mode = "area", Placeholder = First, Value = Message, Save = true }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSTAGRAM
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Instagram = function(Options)
	return Keyboard({
		{ Mode = "options", Placeholder = "Selecione uma opção", Options = Options }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Options = function(First,Second)
	return Keyboard({
		{ Mode = "text", Placeholder = First },
		{ Mode = "options", Placeholder = "Selecione uma opção", Options = Second }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESET
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Timeset = function(First,Second,Third)
	return Keyboard({
		{ Mode = "text", Placeholder = First },
		{ Mode = "text", Placeholder = Second },
		{ Mode = "options", Placeholder = "Selecione uma opção", Options = Third }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Vehicle = function(First,Second,Third,Fourth,Fifth)
	return Keyboard({
		{ Mode = "text", Placeholder = First },
		{ Mode = "text", Placeholder = Second },
		{ Mode = "options", Placeholder = "Selecione uma opção", Options = Third },
		{ Mode = "text", Placeholder = Fourth },
		{ Mode = "options", Placeholder = "Selecione uma opção", Options = Fifth }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINS
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Skins = function(First,Second,Third,Fourth,Fifth)
	return Keyboard({
		{ Mode = "text", Placeholder = First },
		{ Mode = "text", Placeholder = Second },
		{ Mode = "text", Placeholder = Third },
		{ Mode = "text", Placeholder = Fourth },
		{ Mode = "options", Placeholder = "Selecione uma opção", Options = Fifth }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
Form.Item = function(First,Second,Third,Fourth,Fifth)
	return Keyboard({
		{ Mode = "text", Placeholder = First },
		{ Mode = "text", Placeholder = Second },
		{ Mode = "text", Placeholder = Third },
		{ Mode = "options", Placeholder = "Selecione uma opção", Options = Fourth },
		{ Mode = "text", Placeholder = Fifth }
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS & BINDINGS
-----------------------------------------------------------------------------------------------------------------------------------------
for Name,v in pairs(Form) do
	Creative[Name] = v
	exports(Name,v)
end
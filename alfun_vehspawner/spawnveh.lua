Config = {}
	--------------------------------------------------------
	--=====Locations where players can spawn car========--
	--------------------------------------------------------
Config.MarkerVeh = 
{ 
    -- Spawn Vehicle Garsun --

	
	{x = 230.62 ,y =  -796.84 ,z = 29.50},
	{x = 215.0 ,y =  -790.62 ,z = 30.0},
}

ESX = nil
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if ESX ~= nil then
		
		else
			ESX = nil
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		end
	end
end)

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

	
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(Config.MarkerVeh) do
            DrawMarker(1, Config.MarkerVeh[k].x, Config.MarkerVeh[k].y, Config.MarkerVeh[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 0, 150, 150, 100, 0, 0, 0, 0)	
		end
    end
end)
			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(Config.MarkerVeh) do
        	local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped, false)
            local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, Config.MarkerVeh[k].x, Config.MarkerVeh[k].y, Config.MarkerVeh[k].z)
            if distance <= 1.40 then
					DisplayHelpText('Tekan E untuk mengeluarkan Kendaraan ')	
					if IsControlJustPressed(0, Keys['E']) and IsPedOnFoot(ped) then
						OpenVehicleMenu(Config.MarkerVeh[k].xs, Config.MarkerVeh[k].ys, Config.MarkerVeh[k].zs)
					end 
			elseif distance < 1.45 then
				ESX.UI.Menu.CloseAll()
            end
        end
    end
end)

function OpenVehicleMenu(x, y , z)
	local ped = PlayerPedId()
	PlayerData = ESX.GetPlayerData()
	local elements = {}
	--spawn kendaraan warga
	table.insert(elements, {label = '<span style="color:red;">BF400</span>', value = 'veh'}) 
	table.insert(elements, {label = '<span style="color:red;">Sovereign</span>', value = 'veh2'}) 
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'client',
		{
			title    = 'Spawn Kendaraan',
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)
		if data.current.value == 'veh' then
			ESX.UI.Menu.CloseAll()
			TriggerEvent('esx:spawnVehicle', "bf400")
		elseif data.current.value == 'veh2' then
			ESX.UI.Menu.CloseAll()
			TriggerEvent('esx:spawnVehicle', "sovereign")
		end
    end)
end

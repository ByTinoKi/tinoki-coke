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

local PlayerData              = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------- CokeS ------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local spawnedCokes = 0
local CokePlants = {}
local isPickingUpCoke, isProcessingCoke = false, false
local isInSellingProgressCoke = false 
local CokeSellBlip1, CokeSellBlip2, CokeSellBlip3, CokeSellBlip4, CokeSellBlip5 = false, false, false, false, false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.Zones.CokeField.coords, true) < 50 then
			SpawnCokePlants()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		waitTime = 1000
		local coords = GetEntityCoords(PlayerPedId())
		local CokeSellCoords = GetDistanceBetweenCoords(coords, Config.Zones.CokeSell.coords.x, Config.Zones.CokeSell.coords.y, Config.Zones.CokeSell.coords.z, true)
		local CokeSellDelivery_1 = GetDistanceBetweenCoords(coords, Config.Zones.CokeSellPoint_1.coords.x, Config.Zones.CokeSellPoint_1.coords.y, Config.Zones.CokeSellPoint_1.coords.z, true)
		local CokeSellDelivery_2 = GetDistanceBetweenCoords(coords, Config.Zones.CokeSellPoint_2.coords.x, Config.Zones.CokeSellPoint_2.coords.y, Config.Zones.CokeSellPoint_2.coords.z, true)
		local CokeSellDelivery_3 = GetDistanceBetweenCoords(coords, Config.Zones.CokeSellPoint_3.coords.x, Config.Zones.CokeSellPoint_3.coords.y, Config.Zones.CokeSellPoint_3.coords.z, true)
		local CokeSellDelivery_4 = GetDistanceBetweenCoords(coords, Config.Zones.CokeSellPoint_4.coords.x, Config.Zones.CokeSellPoint_4.coords.y, Config.Zones.CokeSellPoint_4.coords.z, true)
		local CokeSellDelivery_5 = GetDistanceBetweenCoords(coords, Config.Zones.CokeSellPoint_5.coords.x, Config.Zones.CokeSellPoint_5.coords.y, Config.Zones.CokeSellPoint_5.coords.z, true)
		
		if CokeSellCoords < 10.0 then
			waitTime = 1
			DrawText3Ds(Config.Zones.CokeSell.coords , Config.Notification4 , 0.4)
			if CokeSellCoords < 2.0 then
				if IsControlJustReleased(0, Keys['E']) then
					if not isInSellingProgressCoke then 
						isInSellingProgressCoke = true
						exports.pNotify:SendNotification({
							text = (Config.Notification6), 
							type = "success", 
							timeout = math.random(3500, 4000), 
							layout = "centerLeft", 
							queue = "left"
						})
						Wait(2500)
						exports.pNotify:SendNotification({
							text = (Config.Notification7), 
							type = "success", 
							timeout = math.random(2500, 3000), 
							layout = "centerLeft", 
							queue = "left"
						})
						CokeSellBlip1 = true 
						blip = AddBlipForCoord(Config.Zones.CokeSellPoint_1.coords)
						SetBlipRoute(blip , true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(Config.BlipName_1)
						EndTextCommandSetBlipName(blip)
					else 
						exports.pNotify:SendNotification({
							text = (Config.Notification5), 
							type = "success", 
							timeout = math.random(3500, 4000), 
							layout = "centerLeft", 
							queue = "left"
						})
					end 
				end 
			end 
		end
		
		if isInSellingProgressCoke then 
			if CokeSellBlip1 then 
				if CokeSellDelivery_1 < 10.0 then 
					waitTime = 1 
					DrawText3Ds(Config.Zones.CokeSellPoint_1.coords , Config.Notification8 , 0.4)
					if CokeSellDelivery_1 < 2.0 then 
						if IsControlJustReleased(0, Keys['E']) then
							SellingCoke()
							RemoveBlip(blip)
							CokeSellBlip1 = false 
							CokeSellBlip2 = true 
							blip = AddBlipForCoord(Config.Zones.CokeSellPoint_2.coords)
							SetBlipRoute(blip , true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(Config.BlipName_2)
							EndTextCommandSetBlipName(blip)
							exports.pNotify:SendNotification({
								text = (Config.Notification10), 
								type = "success", 
								timeout = math.random(3500, 4000), 
								layout = "centerLeft", 
								queue = "left"
							})
						end
					end 
				end 
			elseif CokeSellBlip2 then 
				if CokeSellDelivery_2 < 10.0 then 
					waitTime = 1 
					DrawText3Ds(Config.Zones.CokeSellPoint_2.coords , Config.Notification8 , 0.4)
					if CokeSellDelivery_2 < 2.0 then 
						if IsControlJustReleased(0, Keys['E']) then
							SellingCoke()
							RemoveBlip(blip)
							CokeSellBlip2 = false 
							CokeSellBlip3 = true 
							blip = AddBlipForCoord(Config.Zones.CokeSellPoint_3.coords)
							SetBlipRoute(blip , true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(Config.BlipName_3)
							EndTextCommandSetBlipName(blip)
							exports.pNotify:SendNotification({
								text = (Config.Notification10), 
								type = "success", 
								timeout = math.random(3500, 4000), 
								layout = "centerLeft", 
								queue = "left"
							})
						end
					end 
				end 
			elseif CokeSellBlip3 then 
				if CokeSellDelivery_3 < 10.0 then 
					waitTime = 1 
					DrawText3Ds(Config.Zones.CokeSellPoint_3.coords , Config.Notification8 , 0.4)
					if CokeSellDelivery_3 < 2.0 then 
						if IsControlJustReleased(0, Keys['E']) then
							SellingCoke()
							RemoveBlip(blip)
							CokeSellBlip3 = false 
							CokeSellBlip4 = true 
							blip = AddBlipForCoord(Config.Zones.CokeSellPoint_4.coords)
							SetBlipRoute(blip , true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(Config.BlipName_4)
							EndTextCommandSetBlipName(blip)
							exports.pNotify:SendNotification({
								text = (Config.Notification10), 
								type = "success", 
								timeout = math.random(3500, 4000), 
								layout = "centerLeft", 
								queue = "left"
							})
						end
					end 
				end 
			elseif CokeSellBlip4 then 
				if CokeSellDelivery_4 < 10.0 then 
					waitTime = 1 
					DrawText3Ds(Config.Zones.CokeSellPoint_4.coords , Config.Notification8 , 0.4)
					if CokeSellDelivery_4 < 2.0 then 
						if IsControlJustReleased(0, Keys['E']) then
							SellingCoke()
							RemoveBlip(blip)
							CokeSellBlip4 = false 
							CokeSellBlip5 = true 
							blip = AddBlipForCoord(Config.Zones.CokeSellPoint_5.coords)
							SetBlipRoute(blip , true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(Config.BlipName_5)
							EndTextCommandSetBlipName(blip)
							exports.pNotify:SendNotification({
								text = (Config.Notification10), 
								type = "success", 
								timeout = math.random(3500, 4000), 
								layout = "centerLeft", 
								queue = "left"
							})
						end
					end 
				end 
			elseif CokeSellBlip5 then 
				if CokeSellDelivery_5 < 10.0 then 
					waitTime = 1 
					DrawText3Ds(Config.Zones.CokeSellPoint_5.coords , Config.Notification8 , 0.4)
					if CokeSellDelivery_5 < 2.0 then 
						if IsControlJustReleased(0, Keys['E']) then
							SellingCoke()
							RemoveBlip(blip)
							CokeSellBlip5 = false 
							isInSellingProgressCoke = false 
							exports.pNotify:SendNotification({
								text = (Config.Notification9), 
								type = "success", 
								timeout = math.random(3500, 4000), 
								layout = "centerLeft", 
								queue = "left"
							})
						end
					end 
				end 
			end 
		end 
		Citizen.Wait(waitTime)
	end
end)

RegisterNetEvent('tinoki-coke:harvest')
AddEventHandler('tinoki-coke:harvest', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObjectCoke, nearbyIDCoke
	
	for i=1, #CokePlants, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(CokePlants[i]), false) < Config.DistancePlayerToPlant then
			nearbyObjectCoke, nearbyIDCoke = CokePlants[i], i
		end
	end
		
	if nearbyObjectCoke and IsPedOnFoot(playerPed) then
		if not isPickingUp and not isBusy then
			isBusy = true 
			isPickingUp = true
			exports.rprogress:Custom({
				Duration = (Config.HarvestTime),
				Label = (Config.Notification13),
				Animation = {
					scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
					animationDictionary = "", -- https://alexguirre.github.io/animations-list/
				},
				DisableControls = {
					Mouse = false,
					Player = true,
					Vehicle = true
				}
			})
			Citizen.Wait(Config.HarvestTime)
			ClearPedTasks(playerPed)
			Citizen.Wait(1500)
			ESX.Game.DeleteObject(nearbyObjectCoke)
			table.remove(CokePlants, nearbyIDCoke)
			spawnedCokes = spawnedCokes - 1
			TriggerServerEvent('tinoki-coke:harvestCoke')
			FreezeEntityPosition(PlayerPedId() , false )
	
			isPickingUp = false
			isBusy = false
		end
	else 
		exports.pNotify:SendNotification({
			text = (Config.Notification1), 
			type = "success", 
			timeout = math.random(3500, 4000), 
			layout = "centerLeft", 
			queue = "left"
		})
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(CokePlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnCokePlants()
	while spawnedCokes < Config.TotalPlantInArea do
		Citizen.Wait(0)
		local CokeCoords = GenerateCokeCoords()

		ESX.Game.SpawnLocalObject('prop_sapling_break_02', CokeCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(CokePlants, obj)
			spawnedCokes = spawnedCokes + 1
		end)
	end
end

function ValidateCokeCoord(plantCoord)
	if spawnedCokes > 0 then
		local validate = true

		for k, v in pairs(CokePlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.Zones.CokeField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCokeCoords()
	while true do
		Citizen.Wait(1)

		local CokeCoordX, CokeCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-90, 90)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)

		CokeCoordX = Config.Zones.CokeField.coords.x + modX
		CokeCoordY = Config.Zones.CokeField.coords.y + modY

		local coordZ = GetCoordZ(CokeCoordX, CokeCoordY)
		local coord = vector3(CokeCoordX, CokeCoordY, coordZ)

		if ValidateCokeCoord(coord) then
			return coord
		end
	end
end


function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end

RegisterNetEvent('tinoki-coke:pack')
AddEventHandler('tinoki-coke:pack', function()
	ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tinoki-coke_pack',
        {
            title    = 'Coke - Packing',
            align    = 'top-right',
            elements = { 
                { label = 'Pack Coke - 5 Coke/Pack', value = '1' },
            }
        },
    function(data, menu)
        local value = data.current.value

        if value == '1' then
			ESX.UI.Menu.CloseAll()
			TriggerServerEvent("tinoki-coke:pack", 1)
		end
    end,
    function(data, menu)
        menu.close()
    end)
end)

RegisterNetEvent('tinoki-coke:packing')
AddEventHandler('tinoki-coke:packing', function()
	exports.rprogress:Custom({
		Duration = (Config.PackingTime),
		Label = (Config.Notification14),
		Animation = {
			scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
			animationDictionary = "", -- https://alexguirre.github.io/animations-list/
		},
		DisableControls = {
			Mouse = false,
			Player = true,
			Vehicle = true
		}
	})
	Citizen.Wait(Config.PackingTime)
	ClearPedTasks(PlayerPedId())
end)

---------------------------------------------
-------------- SELLING PARTS ----------------
---------------------------------------------
DrawText3Ds = function(coords, text, scale)
	local x,y,z = coords.x, coords.y, coords.z
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 370

	DrawRect(_x, _y + 0.0140, 0.030 + factor, 0.025, 0, 0, 0, 100)
end

function SellingCoke()
	if not isBusy then 
		isBusy = true 
		exports.rprogress:Custom({
			Duration = (Config.SellingTime),
			Label = (Config.Notification15),
			Animation = {
				scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
				animationDictionary = "", -- https://alexguirre.github.io/animations-list/
			},
			DisableControls = {
				Mouse = false,
				Player = true,
				Vehicle = true
			}
		})
		Citizen.Wait(Config.SellingTime)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent("tinoki-coke:sellCoke")
		FreezeEntityPosition(PlayerPedId() , false )
		isBusy = false
	end
end

RegisterCommand("stopsell", function()
	isBusy = false
	RemoveBlip(blip)
	isInSellingProgressCoke, CokeSellBlip1, CokeSellBlip2, CokeSellBlip3, CokeSellBlip4, CokeSellBlip5 = false, false, false, false, false, false
	exports.pNotify:SendNotification({
		text = (Config.Notification12), 
		type = "success", 
		timeout = math.random(3500, 4000), 
		layout = "centerLeft", 
		queue = "left"
	})
end)
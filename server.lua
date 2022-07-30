ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('scissors', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('disc:close' , source)
	TriggerClientEvent('tinoki-coke:harvest', source)
end)

ESX.RegisterUsableItem('zip_bag', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('disc:close' , source)
	TriggerClientEvent('tinoki-coke:pack', source)
end)

RegisterServerEvent('tinoki-coke:harvestCoke')
AddEventHandler('tinoki-coke:harvestCoke', function()
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local xItem = xPlayer.getInventoryItem('item_coke').count	
	
	if xItem < Config.MaxCoke then
		xPlayer.addInventoryItem('item_coke', Config.CokeFromHarvest)
	else
		TriggerClientEvent("pNotify:SendNotification", source, {text = (Config.Notification2), timeout = 5000})
	end
end)

RegisterServerEvent('tinoki-coke:pack')
AddEventHandler('tinoki-coke:pack', function(stats)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
		
	if stats == 1 then 
		local xCoke = xPlayer.getInventoryItem('item_coke').count
		if xCoke >= Config.CokeToPack then
			xPlayer.removeInventoryItem('zip_bag', 1)
			xPlayer.removeInventoryItem('item_coke', Config.CokeToPack)
			TriggerClientEvent('tinoki-coke:packing', src)
			Citizen.Wait(Config.PackingTime)
			xPlayer.addInventoryItem('packed_coke', 1)
		else
			TriggerClientEvent("pNotify:SendNotification", source, {text = (Config.Notification3), timeout = 5000})
		end
	end
end)

RegisterServerEvent('tinoki-coke:sellCoke')
AddEventHandler('tinoki-coke:sellCoke', function()
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local CokeAmount = math.random(Config.MinCokeSell, Config.MaxCokeSell)
	
	local xCoke = xPlayer.getInventoryItem('packed_coke').count
	if xCoke > CokeAmount then 
		xPlayer.removeInventoryItem("packed_coke", CokeAmount)
		if Config.UseBlackMoney then 
			xPlayer.addAccountMoney('black_money', Config.CokePrice * CokeAmount)
		else
			xPlayer.addMoney(Config.CokePrice * CokeAmount)
		end
	else 
		TriggerClientEvent("pNotify:SendNotification", source, {text = (Config.Notification11), timeout = 5000})
	end 
end)
Config = {}

Config.Zones = {
	CokeField = {coords = vector3(18.6516,3373.7253,40.4475), radius = 50.0}, -- Coordinate for Coke Plant to Spawn within Radius
	CokeSell = {coords = vector3(-1129.8333,-1604.4376,4.3984), radius = 0.0}, -- Coordinate for Coke Selling
	CokeSellPoint_1 = {coords = vector3(320.600006,-1759.500000,29.300000), radius = 0.0}, -- Coordinate for Coke Selling Delivery 1
	CokeSellPoint_2 = {coords = vector3(-716.299988,-864.299988,23.200000), radius = 0.0}, -- Coordinate for Coke Selling Delivery 2
	CokeSellPoint_3 = {coords = vector3(-1223.800048,-711.299988,22.400000), radius = 0.0}, -- Coordinate for Coke Selling Delivery 3
	CokeSellPoint_4 = {coords = vector3(-1356.800048,-211.199996,43.700000), radius = 0.0}, -- Coordinate for Coke Selling Delivery 4
	CokeSellPoint_5 = {coords = vector3(-1308.900024,448.899994,100.599998), radius = 0.0}, -- Coordinate for Coke Selling Delivery 5
}

Config.TotalPlantInArea = 25 -- How many Plants to spawn in the radius area.
Config.DistancePlayerToPlant = 1 -- How far player from the plant to be able to harvest.
Config.HarvestTime = 5000 -- Time in ms 1000 = 1 second
Config.PackingTime = 5000 -- Time in ms 1000 = 1 second
Config.SellingTime = 5000 -- Time in ms 1000 = 1 second
Config.MaxCoke = 100 -- Max Coke on inventory

Config.CokeFromHarvest = 3 -- How many Coke per harvest 
Config.CokeToPack = 5 -- How many Coke per pack
Config.MinCokeSell = 2 -- Minimum Coke to randomise sell, Value must be lower than MaxCokeSell
Config.MaxCokeSell = 3 -- Maximum Coke to randomise sell, Value must be higher than MinCokeSell

Config.UseBlackMoney = false -- Set to true for Black Money, false for Normal Money
Config.CokePrice = 100 -- Price per Coke

Config.BlipName_1 = "Coke Delivery 1" -- Name on the Map
Config.BlipName_2 = "Coke Delivery 2" -- Name on the Map
Config.BlipName_3 = "Coke Delivery 3" -- Name on the Map
Config.BlipName_4 = "Coke Delivery 4" -- Name on the Map
Config.BlipName_5 = "Coke Delivery 5" -- Name on the Map

--Notifications
Config.Notification1 = "No plant nearby!" 
Config.Notification2 = "You dont have enough space to carry more this item!" 
Config.Notification3 = "You dont have enough Coke, you need 5 to make a Pack of Coke!" 
Config.Notification4 = "[E] Start Coke run"
Config.Notification5 = "You already start the progress, go to the delivery area to Sell the Coke!"

Config.Notification6 = "You start the selling progress, go to the delivery area to Sell the Coke!"
Config.Notification7 = "Use command /stopsell to Stop the Selling Progress."
Config.Notification8 = "[E]Deliver Coke"
Config.Notification9 = "You successfuly delivered all the Coke! Congrats!"
Config.Notification10 = "You successfuly delivered the Coke, go to the next Destination!"

Config.Notification11 = "You dont have enough Coke to Sell!"
Config.Notification12 = "You stop the Coke Delivery progress." 
Config.Notification13 = "Cutting plant..."
Config.Notification14 = "Packing Coke..."
Config.Notification15 = "Deliver Coke..."
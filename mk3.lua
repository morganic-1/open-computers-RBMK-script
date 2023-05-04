-- Load the required modules
local term = require("term")
local component = require("component")
local sides = require("sides")
local rs = component.redstone

-- Load all RBMK parts
local boilers = {}

-- Get all the control rods in the reactor
for address, type in component.list("rbmk_boiler") do
    table.insert(boilers, component.proxy(address))
end

-- Set the temperature threshold to 9000mB
local threshold = 9000

-- Main loop
while true do
    
    local boilersAveWater = 0
    local boilersAveHeat = 0
    -- Calculate the average water level and heat level
    for i = 1, #boilers do
        boilersAveWater = boilersAveWater + boilers[i].getWater()
        boilersAveHeat = boilersAveHeat + boilers[i].getHeat()
    end
    boilersAveWater = boilersAveWater / #boilers
    boilersAveHeat = boilersAveHeat / #boilers

    -- Print the average water level and heat level to the console
    print("Average water level:", boilersAveWater)
    print("Average heat level:", boilersAveHeat)

    os.sleep(1)

    term.clear()
end

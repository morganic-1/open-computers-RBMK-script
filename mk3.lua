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

    -- Calculate the average water level
    local waterSum = 0
    local waterMath = 1
    while waterMath < #boilers do
        waterSum = boilers[i].getWater + waterSum
        waterMath = waterMath + 1
    end

    -- Print the average water level to the console
    print("Average water level:", average)


    os.sleep(1)

end
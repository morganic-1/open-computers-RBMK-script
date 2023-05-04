-- load required modules

local term = require("term")
local component = require("component")
local sides = require("sides")
local rs = component.redstone
local screen = component.screen
local gpu = component.screen

-- Set the target temperature to 600 C
local targetTemp = 600

-- Set the temperature threshold to 9000mB of water

local threshold = 9000

-- Create tables for reactor components

local boilers = {}
local fuelRods = {}
local controlRods = {}

-- Insert all reactor components to their table

for address, type in component.list("rbmk_control_rod") do
    table.insert(controlRods, component.proxy(address))
end

for address, type in component.list("rbmk_fuel_rod") do
    table.insert(fuelRods, component.proxy(address))
end

for address, type in component.list("rbmk_boiler") do
    table.insert(boilers, component.proxy(address))
end

-- Clear screen and wait for 1 second

term.clear()
os.sleep(0.05)

-- Start main loop

while true do
    
    local boilersAveWater = 0
    local boilersAveHeat = 0
    local fuelRodsAveTemp = 0
    local controlRodsAveTemp = 0
    
    -- Calculate the averages for all component groups
    
    for i = 1, #boilers do
        boilersAveWater = boilersAveWater + boilers[i].getWater()
        boilersAveHeat = boilersAveHeat + boilers[i].getHeat()
    end

    for i = 1, #fuelRods do
        fuelRodsAveTemp = fuelRodsAveTemp + fuelRods[i].getHeat()
    end

    for i = 1, #controlRods do
        controlRodsAveTemp = controlRodsAveTemp + controlRods[i].getHeat()
    end

    -- Get averages of all reactor values

    boilersAveWater = boilersAveWater / #boilers
    boilersAveHeat = boilersAveHeat / #boilers
    fuelRodsAveTemp = fuelRodsAveTemp / #fuelRods
    controlRodsAveTemp = controlRodsAveTemp / #controlRods

     -- Output a redstone signal if the temperature is above the threshold
    
    if boilersAveWater > threshold then
        rs.setOutput(sides.right, 0)
    else
        rs.setOutput(sides.right, 15)
    end

    -- Adjust the insertion depth of all the control rods

    for i = 1, #controlRods do
        local controlRod = controlRods[i]

     -- If the temperature is too low, increase the control rod insertion depth

    if boilersAveHeat < targetTemp - 50 then
        controlRod.setLevel(controlRod.getLevel() + 10)

    -- If the temperature is too high, decrease the control rod insertion depth

    elseif boilersAveHeat > targetTemp + 50 then
        controlRod.setLevel(controlRod.getLevel() - 10)

    end
end
-- Set the cursor position and print

term.setCursor(5, 1)
term.write("average boiler temp:")
term.setCursor(30, 1)
term.write(boilersAveHeat)

term.setCursor(5, 5)
term.write("average amount of feed Water:")
term.setCursor(35, 5)
term.write(boilersAveWater)

term.setCursor(5, 3)
term.write("average fuel rod temp:")
term.setCursor(30, 3)
term.write(fuelRodsAveTemp)

term.setCursor(5, 7)
term.write("average control rod temp:")
term.setCursor(35, 7)
term.write(controlRodsAveTemp)

os.sleep(0.5)

end
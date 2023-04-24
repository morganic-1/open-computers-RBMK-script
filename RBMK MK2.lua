.-- Load the required module
local term = require("term")
local gpu = require("gpu")
local component = require("component")
local sides = require("sides")
local rs = component.redstone
local fuelRod = {}
local boiler = {}
local controlRods = {}

-- Get all the control rods connected to the computer
for address, type in component.list("rbmk_control_rod") do
    table.insert(controlRods, component.proxy(address))
end

-- get all boilers connected to the computer
for address, type in component.list("rbmk_boiler") do
    table.insert(boiler, component.proxy(address))
end

-- get all fuel rods connected to the computer
for address, type in component.list("rbmk_fuel_rod") do
    table.insert(boiler, component.proxy(address))
end

-- Set the target temperature to 600 C
local targetTemp = 600

-- Set the temperature threshold to 9000mB
local threshold = 9000

-- Main loop
while true do
        -- Get the current reactor temperature

        local temp  = boiler.getHeat()

        -- Get the amount of feed water

        local water = boiler.getWater()

         -- Output a redstone signal if the temperature is above the threshold
        if water > threshold then
            rs.setOutput(sides.right, 0)
        else
            rs.setOutput(sides.right, 15)
        end


        -- Adjust the insertion depth of all the control rods

        for i = 1, #controlRods do
            local controlRod = controlRods[i]

         -- If the temperature is too low, increase the control rod insertion depth

        if temp < targetTemp - 50 then
            controlRod.setLevel(controlRod.getLevel() + 10)

        -- If the temperature is too high, decrease the control rod insertion depth

        elseif temp > targetTemp + 50 then
            controlRod.setLevel(controlRod.getLevel() - 10)

        end

        -- Calculate the average water level

        local sum = 0
        for _, level in ipairs(boiler) do
            sum = #boiler
        end
        local waterAVE = sum / #boiler



    -- Set the cursor position and print
    term.setCursor(5, 5)
    term.write("average boiler temp:")
    term.setCursor(20, 5)
    term.write(temp)

    term.setCursor(5, 15)
    term.write("average # feed water:")
    term.setCursor(20, 15)
    term.write(waterAVE)

    -- Sleep for 1 second

    os.sleep(1)

    -- Clear the screen

    term.clear()
    
end
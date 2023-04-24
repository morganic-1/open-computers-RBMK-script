.-- Load the required module
local term = require("term")
local component = require("component")
local sides = require("sides")
local rs = component.redstone
local fuelRod = component.rbmk_fuel_rod
local boiler = component.rbmk_boiler
local controlRods = {}

-- Get all the control rods in the reactor
for address, type in component.list("rbmk_control_rod") do
    table.insert(controlRods, component.proxy(address))
end

-- Set the target temperature to 600 C
local targetTemp = 600

-- Set the temperature threshold to 9000mB
local threshold = 9000

-- Main loop
while true do
        -- Get the current reactor temperature

        local temp = boiler.getHeat()

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
    end
    -- Set the cursor position and print
    term.setCursor(5, 5)
    term.write("boiler temp:")
    term.setCursor(20, 5)
    term.write(temp)

    term.setCursor(5, 15)
    term.write("Feed Water:")
    term.setCursor(20, 15)
    term.write(water)

    -- Sleep for 1 second

    os.sleep(1)

    -- Clear the screen

    term.clear()
    
end

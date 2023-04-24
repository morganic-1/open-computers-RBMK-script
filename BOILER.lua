-- Load the required module
local term = require("term")
local component = require("component")
local sides = require("sides")
local rs = component.redstone
local boiler = component.rbmk_boiler

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

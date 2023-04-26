-- Load the required components
local component = require("component")
local event = require("event")
local gpu = component.gpu

-- Define the size and position of the button
local buttonX = 5
local buttonY = 5
local buttonWidth = 10
local buttonHeight = 3

-- Draw the button
gpu.setBackground(0xFFFFFF) -- Set the background color to white
gpu.fill(buttonX, buttonY, buttonWidth, buttonHeight, " ") -- Draw a white rectangle
gpu.setForeground(0x000000) -- Set the text color to black
gpu.set(buttonX + buttonWidth / 2 - 2, buttonY + buttonHeight / 2, "Button") -- Draw the text "Button" in the middle of the button

-- Define a function to execute when the button is clicked
local function myScript()
    -- Your code here
    print("Button clicked!")
  end  

-- Wait for a click event
while true do
  local event, _, x, y = event.pull()
  if event == "touch" and x >= buttonX and x <= buttonX + buttonWidth - 1 and y >= buttonY and y <= buttonY + buttonHeight - 1 then
    -- The button was clicked, do something
    myScript()
  end
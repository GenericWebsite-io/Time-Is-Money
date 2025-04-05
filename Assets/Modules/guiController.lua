--[[
    Gui Controller 
    Handles the integration between seperate ui elements and is in charge of managing them.
    Also the main updater.
]]


local guiElements = {}
local guiController = {}
guiController.__index = guiController

local buttonController = require "Assets/Modules/buttonController"
local textboxController = require "Assets/Modules/textboxController"



function guiController.addElement(element)
    --[[
        Attempts to add a given element to the list of GUI elements so long as it is valid.
    ]]

    local requiredFields = {"draw","update","enabled","class"}

    if type(element) ~= "table" then -- Must be a table or it wont work. Lua object stuff. 
        warn("Element must be a table value.")
        return false
    end

    for _, field in pairs(requiredFields) do
        if element[field] == nil then
            warn("Element is missing required field: " .. field)
            return false
        end
    end

    table.insert(guiElements, element)
    return true

end

function guiController.removeElement(element)
    --[[
        Removes given element if it is present in the list.
    ]]

    for i, listElement in pairs(guiElements) do
        print(listElement.class)
        if listElement == element then
            table.remove(guiElements,i)
            return true
        end
    end
    return false

end

function guiController.clearElements()
    guiElements = {}
end

function guiController.drawAll()
    for _, element in pairs(guiElements) do
        element:draw()
    end
end

return guiController
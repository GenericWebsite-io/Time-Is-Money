--[[
    Gui Controller 
    Renders & Updates ui elements as dictated by main.lua
    Capable of loading scenes using 'panels'. Essentially a list of ui elements.
]]


local guiElements = {}
local guiPanels = {}
local GuiController = {}
GuiController.__index = GuiController

colorTheme = {
    backgroundColor = {love.math.colorFromBytes(200,200,200)},
    accentColor = {love.math.colorFromBytes(0,155,125)},
    textColor = {love.math.colorFromBytes(255,255,255)},
    titleColor = {love.math.colorFromBytes(0,200,180)},
}


function GuiController.addElement(element)
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

function GuiController.removeElement(element)
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

function GuiController.clearElements() -- Clears all elements.
    guiElements = {}
    for _, obj in pairs(guiElements) do
        print(obj)
    end
end

function GuiController.createGUI(Name,Table)
    --[[
    This creates a new gui panel, essentially a list of ui elements needed to render
    a specific scene. Useful for switching between something like settings and
    the game.
    ]]
    guiPanels[Name] = Table
end

function GuiController.loadGUI(Name) -- Load a gui panel.
    if guiPanels[Name] == nil then 
        error(Name .. " is not a valid GUI Panel!",2)
     end
     
    GuiController.clearElements()
    for key, value in pairs(guiPanels[Name]) do
        GuiController.addElement(value)
    end
end


--[[
Simple functions to render and update all elements currently active.
]]

function GuiController.drawAll()
    for _, element in pairs(guiElements) do
        element:draw()
    end
end

function GuiController.updateAll()
    for _, element in pairs(guiElements) do
        element:update()
    end
end



return GuiController
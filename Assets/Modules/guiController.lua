--[[
    Gui Controller 
    Handles the integration between seperate ui elements and is in charge of managing them.
    Also the main updater.
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

function GuiController.clearElements()
    guiElements = {}
    for _, obj in pairs(guiElements) do
        print(obj)
    end
end

function GuiController.createGUI(Name,Table)
    guiPanels[Name] = Table
end

function GuiController.loadGUI(Name)
    if guiPanels[Name] == nil then 
        error(Name .. " is not a valid GUI Panel!",2)
     end
     
    GuiController.clearElements()
    for key, value in pairs(guiPanels[Name]) do
        GuiController.addElement(value)
    end
end


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
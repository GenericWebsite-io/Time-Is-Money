

local Textbox = require "Assets.Modules.TextboxClass"
local Textlabel = require "Assets.Modules.TextlabelClass"
local Button = require "Assets.Modules.ButtonClass"

local Instance = {}
Instance.__index = Instance

local registeredClasses = {}

function Instance.register(className, classTable)
    registeredClasses[string.lower(className)] = classTable
end

function Instance.new(className)

    local className = string.lower(className)   
    local class = registeredClasses[className]

    -- Prevent child instances from calling new(), and confirming that the class is registered.
    if getmetatable(name) == Instance then error("Instances cannot create new objects!", 2) end
    if class == nil then error(className .. " is not a registered class!",2) end

    listthing = {}
    listthing.enabled = true
    local instance = registeredClasses[className].new(listthing) -- change this pls. Looks weird.
    setmetatable(class, Instance)

    return instance

end

function Instance:update() end
function Instance:draw() end


Instance.register("Textbox", Textbox)
Instance.register("Textlabel", Textlabel)
Instance.register("Button", Button)

return Instance
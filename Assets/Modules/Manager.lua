
local Instance = require "Assets.Modules.InstanceClass"
local upgrades = require "Assets.Modules.UpgradesList"

local Manager = {}



local resetTime = 0 
local managerTime = 0



local money = 0
local true_ = false -- lol I have no idea why this exists.


function Manager.init()
    resetTime = love.timer.getTime()
    print("Starting funnies.")
    true_ = true
end

function Manager.fetchByID(id)
    for _,table in ipairs(upgrades) do
        for _,upgrade in ipairs(table) do
            if upgrade.id == id then
                return upgrade
            end
        end 
    end
    error("upgrade not find D:")
end

function Manager.update()
    managerTime = love.timer.getTime() - resetTime
end

function Manager.sell()

    local manTime = managerTime -- This is just to ensure the correct amount of time is used as we reset time.
    resetTime = love.timer.getTime()
    -- do upgrade stuff here
    for key, table in ipairs(upgrades) do
        for priority, upgrade in pairs(upgrades[key]) do
            if upgrade.level >= 1 then
                manTime = upgrade.trigger(manTime)
            end
        end
    end
    
    money = money + manTime

end

function Manager.buy(upgrade) -- ID serves as a temporary parameter and may be discarded.
    cost = upgrade.cost()
    level = upgrade.level
    canLevel = upgrade.canLevel
    if money >= cost and canLevel == true then
        money = money - cost
        upgrade.level = upgrade.level + 1
    elseif money >= cost and canLevel == false and level == 0 then
        money = money - cost
        upgrade.level = upgrade.level + 1
    end
end

function Manager.getTime()
    return managerTime
end

function Manager.getMoney()
    return money
end

function Manager.getUpgrades()
    return upgrades
end

return Manager
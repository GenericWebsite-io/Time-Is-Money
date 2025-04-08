
local Instance = require "Assets.Modules.InstanceClass"

local Manager = {}
local upgrades = {}
upgrades[1] = {}
upgrades[2] = {}
upgrades[3] = {}
upgrades[4] = {}


local resetTime = 0 
local managerTime = 0

testUpgrade = Instance.new("upgrade")
testUpgrade.mult = 1.1
testUpgrade.priority = 2
testUpgrade.canLevel = true
testUpgrade.level = 1
testUpgrade.cost = function() if level == 0 then return 10 else return 10*testUpgrade.level end end
testUpgrade.trigger = function(time)
    return time * testUpgrade.mult^testUpgrade.level
end



local money = 0
local true_ = false -- lol I have no idea why this exists.


function Manager.init()
    resetTime = love.timer.getTime()
    print("Starting funnies.")
    true_ = true

    table.insert(upgrades[testUpgrade.priority],testUpgrade)
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
            money = money + upgrade.trigger(manTime)
        end
    end
    
end

function Manager.buy(id) -- ID serves as a temporary parameter and may be discarded.
    if id == 1 and money >= testUpgrade.cost() then
        money = money - testUpgrade.cost()
        testUpgrade.level = testUpgrade.level + 1
    end
end

function Manager.getTime()
    return managerTime
end

function Manager.getMoney()
    return money
end

return Manager
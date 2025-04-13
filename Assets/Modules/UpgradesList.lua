local Instance = require "Assets.Modules.InstanceClass"

--[[
List of all valid upgrades.
]]


local upgrades = {}
upgrades[1] = {}
upgrades[2] = {}
upgrades[3] = {}
upgrades[4] = {}

function add(upgrade) table.insert(upgrades[upgrade.priority], upgrade) end

testUpgrade = Instance.new("upgrade")
testUpgrade.id = "test"
testUpgrade.mult = 1.1
testUpgrade.priority = 2
testUpgrade.canLevel = true
testUpgrade.level = 50
testUpgrade.cost = function() return 10+testUpgrade.level*10 end
testUpgrade.trigger = function(time)
    return time * testUpgrade.mult^testUpgrade.level
end

ultUpgrade = Instance.new("upgrade")
ultUpgrade.id = "ultimate_"
ultUpgrade.mult = 2
ultUpgrade.priority = 4
ultUpgrade.canLevel = true
ultUpgrade.level = 1
ultUpgrade.cost = function() return 10+ultUpgrade.level*10 end
ultUpgrade.trigger = function(time)
    return time*time
end


add(testUpgrade)
add(ultUpgrade)

return upgrades
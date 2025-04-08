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

function Manager.update()
    managerTime = love.timer.getTime() - resetTime
end

function Manager.sell()
    resetTime = love.timer.getTime()
end

function Manager.getTime()
    return managerTime
end

return Manager
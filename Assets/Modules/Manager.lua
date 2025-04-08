local Manager = {}

local resetTime = 0 
local managerTime = 0

local money = 0
local mult = 1
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
    
    local manTime = managerTime -- This is just to ensure the correct amount of time is used as we reset time.
    resetTime = love.timer.getTime()

    -- do upgrade stuff here
    money = money + manTime * mult
    
end

function Manager.buy(id) -- ID serves as a temporary parameter and may be discarded.
    if id == 1 and money >= 4 then
        money = money - 4 
        mult = mult + 1
    end
end

function Manager.getTime()
    return managerTime
end

function Manager.getMoney()
    return money
end

return Manager
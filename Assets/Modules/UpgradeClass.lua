
local Upgrade = {}
Upgrade.__index = Upgrade

-- Early development of upgrade class.
function Upgrade.new(instance)
    --[[
        Upgrade constructor.
    ]]
    instance.class = "upgrade"
    instance.id = "id"
    instance.priority = 0
    instance.canLevel = false
    instance.level = 0
    instance.cost = function() warn("Upgrade.cost is not implemented.") return 0 end
    instance.trigger = function() warn("Upgrade.trigger is not implemented.") return 0 end

    --for k,v in pairs(Upgrade) do instance[k] = v end -- Assigns key value pairs for all the functions in Upgrade onto Instance.
   
    return instance
end


return Upgrade

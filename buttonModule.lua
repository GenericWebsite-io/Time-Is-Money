buttonMaster = {}  -- Class definition
buttonMaster.buttons = {}
buttonMaster.__index = buttonMaster  -- Enables inheritance

local globalCooldown = .1

function buttonMaster.new(text,x,y,width,height,sfx)

    -- Prevent instances from calling new()
    if getmetatable(name) == buttonMaster then
        error("Instances cannot create new objects!", 2)
    end

    local buttonObj = {
        text = text,
        x = x,
        y = y,
        width = width,
        height = height,
        active = false,
        hovering = false, -- Is mouse hovering.
        triggerTime = 0,
        sfx = sfx,
    }

    setmetatable(buttonObj, buttonMaster)  -- Set metatable to allow inheritance
    table.insert(buttonMaster.buttons, buttonObj)
    print(buttonMaster.buttons)
    return buttonObj
end


function buttonMaster:getSize()
    return self.width,self.height
end

function buttonMaster:getPosition()
    return self.x,self.y
end

function buttonMaster:mouseHover(x,y) -- Check if mouse is hovering over the button.
    buttonX, buttonY = self:getPosition()
    buttonWidth, buttonHeight = self:getSize()
    if x > buttonX and x < (buttonX  + buttonWidth) then
        if y > buttonY and y < (buttonY + buttonHeight) then
            return true
        end
    end

    return false
end

function buttonMaster:click(x,y)
    if not self.active and self:mouseHover(x,y) then
        self.active = true
        self.triggerTime = love.timer.getTime() + globalCooldown
        love.audio.play(self.sfx)
        print("Button clicked!")
    end
end

function buttonMaster:update(mouseX, mouseY) -- Simply updates the button logic to see if the timer is done or not.
    if self.active then
        if self.triggerTime < love.timer.getTime() then
            self.active = false
        end
    end

    self.hovering = self:mouseHover(mouseX, mouseY)
    

end

function buttonMaster:draw()
    love.graphics.setFont(fontNormal)
    if self.hovering then 
        love.graphics.setColor(love.math.colorFromBytes(0,165,135))
    else
        love.graphics.setColor(love.math.colorFromBytes(0,155,125))
    end
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    love.graphics.setColor(love.math.colorFromBytes(255,255,255))
    love.graphics.printf(self.text,self.x,self.y + (self.height - love.graphics.getFont():getHeight())/2,self.width,"center")
end


buttonMaster = {}  -- Class definition
buttonMaster.buttons = {}
buttonMaster.__index = buttonMaster  -- Enables inheritance

function buttonMaster.new(text,x,y,width,height)

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

function buttonMaster:click()
    print("Button clicked!")
end

function buttonMaster:isClicked(x,y)
    buttonX, buttonY = button:getPosition()
    buttonWidth, buttonHeight = button:getSize()
    if x > buttonX and x < (buttonX  + buttonWidth) then
        if y > buttonY and y < (buttonY + buttonHeight) then
            button:click()
        end
    end
end

function buttonMaster:draw()
    love.graphics.setFont(fontNormal)
    love.graphics.setColor(love.math.colorFromBytes(0,155,125))
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    love.graphics.setColor(love.math.colorFromBytes(255,255,255))
    love.graphics.printf(self.text,self.x,self.y + (self.height - love.graphics.getFont():getHeight())/2,self.width,"center")
end


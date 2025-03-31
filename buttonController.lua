
--[[
    ABSTRACT BUTTON CLASS
]]

buttonController = {}  -- Class definition.
buttonController.buttons = {}
buttonController.__index = buttonController  -- Enables inheritance.

local globalCooldown = .1 -- Global cooldown variable. Basically the amount of time (in seconds) all buttons have to wait.

function buttonController.new(text,x,y,width,height,sfx)
        --[[
        Creates a new button instance and appends it to a list of buttons.
        All buttons have a set of properties and functions inherited from buttonController.
        ]]

    -- Prevent instances from calling new().
    if getmetatable(name) == buttonController then
        error("Instances cannot create new objects!", 2)
    end

    local buttonObj = {
        text = text,
        x = x,
        y = y,
        width = width,
        height = height,
        active = false, -- Has the button been triggered.
        hovering = false, -- Is mouse hovering.
        triggerTime = 0, -- How long ago since triggered.
        sfx = sfx,
    }

    setmetatable(buttonObj, buttonController)  -- Set metatable to allow inheritance.
    table.insert(buttonController.buttons, buttonObj) -- Insert it in the buttons list for easy updating.
    return buttonObj
end


function buttonController:getSize()
    return self.width,self.height
end

function buttonController:getPosition()
    return self.x,self.y
end

function buttonController:mouseHover(x,y)
    --[[
        Checks whether or not the given X,Y coordinates are within the confines
        of the button instance. Used to check if the mouse is hovering over the button. 
    ]] 
    buttonX, buttonY = self:getPosition()
    buttonWidth, buttonHeight = self:getSize()
    if x > buttonX and x < (buttonX  + buttonWidth) then
        if y > buttonY and y < (buttonY + buttonHeight) then
            return true
        end
    end

    return false
end

function buttonController:click(x,y) -- Abstract function, intended to be overwritten.
    if not self.active and self:mouseHover(x,y) then
        self.active = true
        self.triggerTime = love.timer.getTime() + globalCooldown
        self.x = math.random(0,love.graphics.getWidth())
        self.y = math.random(0,love.graphics.getHeight())
        love.audio.stop(self.sfx)
        love.audio.play(self.sfx)
        print("Button clicked!")
    end
end

function buttonController.update(mouseX, mouseY)
    --[[
        Iterates through all created button instances and updates all relevant information.
        Is in charge of cooldown and checking wheter the cursor is over the button or not.
    ]]
    for _, buttonObj in pairs(buttonController.buttons) do 
        if buttonObj.active then
            if buttonObj.triggerTime < love.timer.getTime() then
                buttonObj.active = false
            end
        end
        buttonObj.hovering = buttonObj:mouseHover(mouseX, mouseY)
    end
end

function buttonController:draw() 
    --[[
        Draws the button. Needs work because it's very poorly written and could use some beautification.
    ]]
    love.graphics.setFont(fontNormal)
    love.graphics.setColor(love.math.colorFromBytes(0,155,125))
    if self.hovering then 
        love.graphics.setColor(love.math.colorFromBytes(0,195,165))
    end
    if self.active then
        love.graphics.setColor(love.math.colorFromBytes(0,255,215))
    end
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    love.graphics.setColor(love.math.colorFromBytes(255,255,255))
    love.graphics.printf(self.text,self.x,self.y + (self.height - love.graphics.getFont():getHeight())/2,self.width,"center")
end



--[[
    ABSTRACT BUTTON CLASS
]]

Button = {}  -- Class definition.
buttonList = {} -- Establishes a list for instance storing and easy updating.
Button.__index = Button  -- Enables inheritance.

local globalCooldown = .1 -- Global cooldown variable. Basically the amount of time (in seconds) all buttons have to wait.

function Button.new(instance)
    --[[
        Textlabel constructor.
    ]]
    instance.class = "button"
    instance.x = 0
    instance.y = 0
    instance.width = 200
    instance.height = 50
    instance.limit = 200
    instance.active = false
    instance.hovering = false
    instance.triggerTime = 0
    instance.sfx = nil
    instance.anchor = {x=0,y=0}
    instance.text = "text"
    instance.font = fontNormal
    instance.textColor = colorTheme.textColor
    for k,v in pairs(Button) do instance[k] = v end -- Assigns key value pairs for all the functions in Textlabel onto Instance.

    table.insert(buttonList,instance)

    return instance
end

function Button:getSize()
    return self.width,self.height
end

function Button:getPosition()
    return self.x+self.anchor.x,self.y+self.anchor.y
end

function Button:setPos(X,Y)
    if type(X) == "table" then
        self.x = X["x"]
        self.y = X["y"]
    else
        self.x = X
        self.y = Y
    end
end

function Button:setSize(Width,Height)
    if type(Width) == "table" then
        self.width = Width["width"] 
        self.height = Width["height"] 
    else
        self.width = Width 
        self.height = Height
    end
end

function Button:mouseHover(x,y)
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

function Button:click(x,y) -- Abstract function, intended to be overwritten.
    if not self.active and self:mouseHover(x,y) then
        self.active = true
        self.triggerTime = love.timer.getTime() + globalCooldown
        self.x = math.random(0,love.graphics.getWidth())
        self.y = math.random(0,love.graphics.getHeight())
        if self.sfx then
            love.audio.stop(self.sfx)
            love.audio.play(self.sfx)
        end
        print("Button clicked!")
    end
end

function Button.update()
    --[[
        Iterates through all created button instances and updates all relevant information.
        Is in charge of cooldown and checking wheter the cursor is over the button or not.
    ]]
    mouseX, mouseY = love.mouse.getPosition()
    for _, buttonObj in ipairs(buttonList) do 
        if buttonObj.active then
            if buttonObj.triggerTime < love.timer.getTime() then
                buttonObj.active = false
            end
        end
        buttonObj.hovering = buttonObj:mouseHover(mouseX, mouseY)
    end
end

function Button:draw() 
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

function Button.mousepressed(x, y, mouseButton, istouch, presses)
    if mouseButton == 1 then
        for _, buttonObj in pairs(buttonList) do
            if buttonObj.hovering and buttonObj.enabled then buttonObj:click(x,y) end
        end
    end
end



return Button
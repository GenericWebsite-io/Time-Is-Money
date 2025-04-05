
local textboxController = {}
textboxController.textBoxes = {}
textboxController.__index = textboxController



-- Need to rename the things to textbox instead of textBox

function textboxController.new(text, x, y, width, height, anchor)
    --[[
        Textbox constructor.
    ]]

    -- Prevent child instances from calling new().
    if getmetatable(name) == textboxController then
        error("Instances cannot create new objects!", 2)
    end

    if anchor == nil then anchor = {x=0,y=0} end --Locks the textbox to 0,0 if no anchor is specified.

    local textBoxOBJ = {
        class = "textbox",
        enabled = true,
        text = text,
        textColor = colorTheme.textColor,
        font = fontNormal,
        x = x,
        y = y,
        width = width,
        height = height,
        limit = width,
        accentColor = colorTheme.accentColor,
        anchor = anchor
    }

    setmetatable(textBoxOBJ, textboxController)
    table.insert(textboxController.textBoxes, textBoxOBJ)

    return textBoxOBJ

end


function textboxController.convertLabel(textbox)
    textbox["draw"] = function()
        local xPos = textbox.x + textbox.anchor.x
        local yPos = textbox.y + textbox.anchor.y 

        love.graphics.setColor(textbox.textColor)
        love.graphics.setFont(textbox.font)
        love.graphics.printf(textbox.text,xPos,yPos + (textbox.height - love.graphics.getFont():getHeight())/2,textbox.limit,"center")
    end
    return textbox
end


function textboxController:draw()

    local xPos = self.x + self.anchor.x
    local yPos = self.y + self.anchor.y 

    love.graphics.setColor(self.accentColor)
    love.graphics.rectangle("fill",xPos, yPos, self.width, self.height)
    love.graphics.setColor(self.textColor)
    love.graphics.setFont(self.font)
    love.graphics.printf(self.text,xPos,yPos + (self.height - love.graphics.getFont():getHeight())/2 ,self.width,"center")
end

function textboxController:update()
    
end


return textboxController

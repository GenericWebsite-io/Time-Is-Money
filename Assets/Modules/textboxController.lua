
local textboxController = {}
textboxController.textBoxes = {}
textboxController.__index = textboxController

backgroundColor = {love.math.colorFromBytes(200,200,200)}
accentColor = {love.math.colorFromBytes(0,155,125)}
textColor = {love.math.colorFromBytes(255,255,255)}

-- Need to rename the things to textbox instead of textBox

function textboxController.new(text, x, y, width, height)
    --[[
        Textbox constructor.
    ]]

    -- Prevent child instances from calling new().
    if getmetatable(name) == textboxController then
        error("Instances cannot create new objects!", 2)
    end

    local textBoxOBJ = {
        class = "textbox",
        enabled = true,
        text = text,
        x = x,
        y = y,
        width = width,
        height = height,
    }

    setmetatable(textBoxOBJ, textboxController)
    table.insert(textboxController.textBoxes, textBoxOBJ)

    return textBoxOBJ

end


function textboxController:draw()
    love.graphics.setColor(accentColor)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(textColor)
    love.graphics.printf(self.text,self.x,self.y + (self.height - love.graphics.getFont():getHeight())/2 ,self.width,"center")
end

function textboxController:update()
    warn("textbox:update() not implemented.")
end


return textboxController


local Textbox = {}
Textbox.__index = Textbox



-- Need to rename the things to textbox instead of textBox
function Textbox.new(instance)
    --[[
        Textbox constructor.
    ]]

    instance.class = "textbox"
    instance.x = 0
    instance.y = 0
    instance.width = 200
    instance.height = 50
    instance.limit = 200
    instance.anchor = {x=0,y=0}
    instance.text = "text"
    instance.font = fontNormal
    instance.textColor = colorTheme.textColor
    instance.accentColor = colorTheme.accentColor

    for k,v in pairs(Textbox) do instance[k] = v end -- Assigns key value pairs for all the functions in Textbox onto Instance.

    return instance
end

function Textbox:draw()

    local xPos = self.x + self.anchor.x
    local yPos = self.y + self.anchor.y 

    love.graphics.setColor(self.accentColor)
    love.graphics.rectangle("fill",xPos, yPos, self.width, self.height)
    love.graphics.setColor(self.textColor)
    love.graphics.setFont(self.font)
    love.graphics.printf(self.text,xPos,yPos + (self.height - love.graphics.getFont():getHeight())/2 ,self.limit,"center")
end

function Textbox:update()
    
end


return Textbox

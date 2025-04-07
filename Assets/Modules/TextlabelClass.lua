
local Textlabel = {}
Textlabel.__index = Textlabel



-- Need to rename the things to Textlabel instead of Textlabel
function Textlabel.new(instance)
    --[[
        Textlabel constructor.
    ]]
    instance.class = "textlabel"
    instance.x = 0
    instance.y = 0
    instance.width = 200
    instance.height = 50
    instance.limit = 200
    instance.anchor = {x=0,y=0}
    instance.text = "text"
    instance.font = fontNormal
    instance.textColor = colorTheme.textColor
    for k,v in pairs(Textlabel) do instance[k] = v end -- Assigns key value pairs for all the functions in Textlabel onto Instance.

    
    return instance
end

function Textlabel:setPos(X,Y)
    if type(X) == "table" then
        self.x = X["x"]
        self.y = X["y"]
    else
        self.x = X
        self.y = Y
    end
end

function Textlabel:setSize(Width,Height)
    if type(Width) == "table" then
        self.width = Width["width"] 
        self.height = Width["height"] 
    else
        self.width = Width 
        self.height = Height
    end
end

function Textlabel:draw()

    local xPos = self.x + self.anchor.x
    local yPos = self.y + self.anchor.y 

    love.graphics.setColor(self.textColor)
    love.graphics.setFont(self.font)
    love.graphics.printf(self.text,xPos,yPos + (self.height - love.graphics.getFont():getHeight())/2 ,self.limit,"center")
end

function Textlabel:update()
    
end


return Textlabel

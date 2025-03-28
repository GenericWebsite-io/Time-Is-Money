

screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

function drawText(text, x, y)
    limit = 200
    love.graphics.printf(text,x-limit/2,y,limit,"center")
end

function love.draw()
    love.graphics.setColor(love.math.colorFromBytes(0,150,120))
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    love.graphics.setColor(255,255,255)
    drawText("Hello darkness my old friend!AAAAAAAAAAAAAAAAAAA", screenWidth/8, screenHeight/8)
end
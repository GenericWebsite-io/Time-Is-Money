


local backgroundColor = {love.math.colorFromBytes(80,80,80)}
local accentColor = {love.math.colorFromBytes(0,200,180)}



require "buttonModule"














function love.load()

    --love.window.setMode(1940,1080)

    screenHeight = love.graphics.getHeight()
    screenWidth = love.graphics.getWidth()
    
    clickSfx = love.audio.newSource("Sfx/clickSFX1.mp3", "stream")
    
    fontBig = love.graphics.newFont("MyFont.ttf",50)
    fontNormal = love.graphics.newFont("MyFont.ttf",24)
    fontSmall = love.graphics.newFont("MyFont.ttf",18)
    
 
    uiPlacement = {}

    uiPlacement.title = {
        x = 0,
        y = 0,
    }

    uiPlacement.underTitle = {
        x = uiPlacement.title.x,
        y = uiPlacement.title.y + 50,
    }

    uiPlacement.buttonStart = {
        x = uiPlacement.title.x + 40,
        y = uiPlacement.title.y + 100,
    }

    button = buttonMaster.new("Start", uiPlacement.buttonStart.x, uiPlacement.buttonStart.y, 200,50, clickSfx)


end


function drawText(text, x, y, limit, big)
    if big then
        love.graphics.setFont(fontBig)
    else
        love.graphics.setFont(fontSmall)
    end
    love.graphics.setColor(accentColor)
    love.graphics.printf(text,x,y,limit,"center")
    love.graphics.setFont(fontSmall)
end


function love.mousepressed(x, y, mouseButton, istouch, presses)
    if mouseButton == 1 then
        for _, buttonObj in pairs(buttonMaster.buttons) do
            buttonObj:click(x,y)
        end
    end
end


function love.update()
    for _, buttonObj in pairs(buttonMaster.buttons) do -- Looping through all currently active buttons and updating their status.
        buttonObj:update(love.mouse.getPosition())
    end
end

function love.draw()
    love.graphics.setColor(backgroundColor)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    love.graphics.setColor(255,255,255)
    drawText("Time is Money", uiPlacement.title.x, uiPlacement.title.y, 400, true)
    drawText("Version 0.0: Genesis", uiPlacement.underTitle.x, uiPlacement.underTitle.y, 250, false)
    for _, buttonObj in pairs(buttonMaster.buttons) do -- Looping through all currently active buttons and updating their status.
        buttonObj:draw()
    end
end




local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local backgroundColor = {love.math.colorFromBytes(80,80,80)}
local accentColor = {love.math.colorFromBytes(0,200,180)}

fontBig = love.graphics.newFont("MyFont.ttf",50)
fontNormal = love.graphics.newFont("MyFont.ttf",24)
fontSmall = love.graphics.newFont("MyFont.ttf",18)

require "buttonModule"









local uiPlacement = {

    title = {
        x = screenWidth * 0.2,
        y = screenHeight * 0.05,
    },

    underTitle = {
        x = screenWidth * 0.11,
        y = screenHeight * 0.15,
    },

    buttonStart = {
        x = screenWidth * 0.02,
        y = screenHeight * 0.25,
    }
}

button = buttonMaster.new("Start", uiPlacement.buttonStart.x, uiPlacement.buttonStart.y, 200,50)



function drawText(text, x, y, limit, big)
    if big then
        love.graphics.setFont(fontBig)
    else
        love.graphics.setFont(fontSmall)
    end
    love.graphics.setColor(accentColor)
    love.graphics.printf(text,x-limit/2,y,limit,"center")
    love.graphics.setFont(fontSmall)
end


function love.mousepressed(x, y, mouseButton, istouch, presses)
    if mouseButton == 1 then
        for _, buttonObj in pairs(buttonMaster.buttons) do
            buttonObj:isClicked(x,y)
        end
    end
end

function love.load()
    print("cool!")
end

function love.draw()
    love.graphics.setColor(backgroundColor)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    love.graphics.setColor(255,255,255)
    drawText("Time is Money", uiPlacement.title.x, uiPlacement.title.y, 400, true)
    drawText("Version 0.0: Genesis", uiPlacement.underTitle.x, uiPlacement.underTitle.y, 250, false)
    button:draw()
end


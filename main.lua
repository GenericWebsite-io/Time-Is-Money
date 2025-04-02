
function love.load()
    --[[
        Loads all variables and modules into the global scope because it cannot be accessed outside
        this given function outside which has me a tad bit confused but oh well.

        I say that then proceed to load path variables into the local scope. :3
    ]]


    local assetsPath = "Assets/"
    local fontPath = assetsPath .. "Font/"
    local sfxPath = assetsPath .. "Sfx/"
    local imgPath = assetsPath .. "Images/"
    local modulePath = assetsPath .. "Modules/"


    -- Due to how require works it is not possible to pass the variable {modulePath} because it expects the name of the module, not path..
    require "Assets/Modules/buttonController" 

    --love.window.setMode(1940,1080)

    screenHeight = love.graphics.getHeight()
    screenWidth = love.graphics.getWidth()
    
    theme = {
        backgroundColor = {love.math.colorFromBytes(80,80,80)},
        accentColor = {love.math.colorFromBytes(0,200,180)},
    }

    clickSfx = love.audio.newSource(sfxPath.."clickSFX1.mp3", "stream")
    
    local myFont = fontPath.."MyFont.ttf"

    fontBig = love.graphics.newFont(myFont,50)
    fontNormal = love.graphics.newFont(myFont,24)
    fontSmall = love.graphics.newFont(myFont,18)
    
 
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

    button = buttonController.new("Start", uiPlacement.buttonStart.x, uiPlacement.buttonStart.y, 200,50, clickSfx)


end


function drawText(text, x, y, limit, big) -- Pretty pointless function. Planning on implementing another object class for managing text & text boxes.
    if big then
        love.graphics.setFont(fontBig)
    else
        love.graphics.setFont(fontSmall)
    end
    love.graphics.setColor(theme.accentColor)
    love.graphics.printf(text,x,y,limit,"center")
    love.graphics.setFont(fontSmall)
end


function love.mousepressed(x, y, mouseButton, istouch, presses)
    if mouseButton == 1 then
        for _, buttonObj in pairs(buttonController.buttons) do
            buttonObj:click(x,y) -- Change to make use of the hover property, instead of itterating through all buttons. :p 
            -- (She means make use of the variable hover. In other words, if hover, that means we probably clicked that button.)
        end
    end
end


function love.update()
    buttonController.update(love.mouse.getPosition())
end

function love.draw() -- Needs to be replaced with other stuff. Probably a game handler. Something that can switch stuff around. Like from main menu to game.
    love.graphics.setColor(theme.backgroundColor)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    love.graphics.setColor(255,255,255)
    drawText("Time is Money", uiPlacement.title.x, uiPlacement.title.y, 400, true)
    drawText("Version 0.0: Genesis", uiPlacement.underTitle.x, uiPlacement.underTitle.y, 250, false)
    
    for _, buttonObj in pairs(buttonController.buttons) do -- Looping through all currently active buttons and updating their status.
        buttonObj:draw()
    end
end


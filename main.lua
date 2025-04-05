
function love.load()
    --[[
    Loads all variables and modules into the global scope because it cannot be accessed outside
    this given function outside which has me a tad bit confused but oh well.
    ]]

    function warn(msg)
        print("[WARNING]: " .. msg)
    end


    local assetsPath = "Assets/"
    local fontPath = assetsPath .. "Font/"
    local sfxPath = assetsPath .. "Sfx/"
    local imgPath = assetsPath .. "Images/"
    local modulePath = assetsPath .. "Modules/"


    -- Due to how require works it is not possible to pass the variable {modulePath} because it expects the name of the module, not path.
    guiController = require "Assets/Modules/guiController"
    buttonController = require "Assets/Modules/buttonController" 
    textboxController = require "Assets/Modules/textboxController" 

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
        y = 10,
    }

    uiPlacement.underTitle = {
        x = uiPlacement.title.x + 5,
        y = uiPlacement.title.y + 30,
    }

    uiPlacement.buttonStart = {
        x = uiPlacement.title.x + 40,
        y = uiPlacement.title.y + 100,
    }

    local titleLabel = textboxController.convertLabel(textboxController.new("Time is Money", uiPlacement.title.x, uiPlacement.title.y,400,50))
    local undertitleLabel = textboxController.convertLabel(textboxController.new("Version 0.1: Evolution", uiPlacement.underTitle.x, uiPlacement.underTitle.y,250,50))
    
    titleLabel.font = fontBig
    titleLabel.textColor = colorTheme.titleColor
    titleLabel.limit = 400

    undertitleLabel.font = fontSmall
    undertitleLabel.textColor = colorTheme.titleColor
    undertitleLabel.limit = 250

    local button = buttonController.new(textboxController.new("Start",uiPlacement.buttonStart.x, uiPlacement.buttonStart.y, 200, 50) ,clickSfx)


    guiController.addElement(button)
    guiController.addElement(titleLabel)
    guiController.addElement(undertitleLabel)
    
    --guiController.clearElements()
end

function love.mousepressed(x, y, mouseButton, istouch, presses)
    if mouseButton == 1 then
        for _, buttonObj in pairs(buttonController.buttons) do
            if buttonObj.hovering and buttonObj.enabled then buttonObj:click(x,y) end
        end
    end
end


function love.update()
    guiController.updateAll()
end

function love.draw() -- Needs to be replaced with other stuff. Probably a game handler. Something that can switch stuff around. Like from main menu to game.
    love.graphics.setColor(theme.backgroundColor)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    guiController.drawAll()
end



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
    Button = require "Assets/Modules/ButtonClass"
    Instance = require "Assets/Modules/InstanceClass"


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
    
    local titleLabel = Instance.new("Textlabel")
    titleLabel.text = "Time is Money"
    titleLabel:setPos(10,0)
    titleLabel:setSize(400,100)
    titleLabel.limit = 325
    titleLabel.font = fontBig
    titleLabel.textColor = colorTheme.titleColor

    local underTitleLabel = Instance.new("Textlabel")
    underTitleLabel.text = "Version: 0.12 - Instances"
    underTitleLabel:setPos(-20,55)
    underTitleLabel:setSize(250,50)
    underTitleLabel.anchor = titleLabel
    underTitleLabel.limit = 250
    underTitleLabel.font = fontSmall
    underTitleLabel.textColor = colorTheme.titleColor

    local startButton = Instance.new("Button")
    startButton.text = "Start"
    startButton:setPos(20,150)
    startButton:setSize(200,50)
    startButton.limit = 200
    startButton.textColor = colorTheme.titleColor
    startButton["click"] = function()
        guiController.clearElements()
    end

    guiController.addElement(titleLabel)
    guiController.addElement(underTitleLabel)
    guiController.addElement(startButton)


end

function love.mousepressed(x, y, mouseButton, istouch, presses)
    Button.mousepressed(x,y,mouseButton,istouch,presses)
end


function love.update()
    guiController.updateAll()
end

function love.draw() -- Needs to be replaced with other stuff. Probably a game handler. Something that can switch stuff around. Like from main menu to game.
    love.graphics.setColor(theme.backgroundColor)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    guiController.drawAll()
end


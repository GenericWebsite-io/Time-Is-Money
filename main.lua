
function love.load()
    --[[
        Loads all variables and modules into the global scope because it cannot be accessed outside
        this given function outside which has me a tad bit confused but oh well.

        I say that then proceed to load path variables into the local scope. :3
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
    GuiController = require "Assets/Modules/GuiController"
    Manager = require "Assets/Modules/Manager"
    upgrades = Manager.getUpgrades()
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
    underTitleLabel.text = "Version: 0.22 - I need to make version a variable, the version."
    underTitleLabel:setPos(-15,55)
    underTitleLabel:setSize(500,50)
    underTitleLabel.anchor = titleLabel
    underTitleLabel.limit = 500
    underTitleLabel.font = fontSmall
    underTitleLabel.textColor = colorTheme.titleColor

    local startButton = Instance.new("Button")
    startButton.text = "Start"
    startButton:setPos(20,150)
    startButton:setSize(200,50)
    startButton.limit = 200
    startButton.textColor = colorTheme.titleColor
    startButton.click = function()
        Manager.init()
        GuiController.loadGUI("game")
    end

    ---

    local testLabel = Instance.new("Textlabel")
    testLabel.text = "Main Screen"
    testLabel:setPos(screenWidth*0.5-200,screenHeight*0.5-50)
    testLabel:setSize(400,100)
    testLabel.limit = 400
    testLabel.font = fontBig
    testLabel.textColor = colorTheme.titleColor

    local sellButton = Instance.new("Button")
    sellButton.text = "Sell"
    sellButton:setPos(screenWidth*0.5-100,screenHeight*0.5+125)
    sellButton:setSize(200,50)
    sellButton.limit = 200
    sellButton.textColor = colorTheme.titleColor
    sellButton.click = function()
        Manager.sell()
    end

    local buyButton = Instance.new("Button")
    buyButton.text = "Buy Upgrade. Cost:$" .. testUpgrade.cost()
    buyButton:setPos(screenWidth*0.5-100,screenHeight*0.5+50)
    buyButton:setSize(200,50)
    buyButton.limit = 200
    buyButton.textColor = colorTheme.titleColor
    buyButton.click = function()
        local upg = Manager.fetchByID("test")
        print(upg)
        Manager.buy(upg)
        buyButton.text = "Buy Upgrade. Cost:$" .. testUpgrade.cost()
    end


    local timeLabel = Instance.new("Textlabel")
    timeLabel.text = "Time:0"
    timeLabel:setPos(0,0)
    timeLabel:setSize(100,50)
    timeLabel.limit = 100
    timeLabel.font = fontSmall
    timeLabel.textColor = colorTheme.titleColor
    timeLabel.update = function()
        timeLabel.text = string.format("Time:%.2f",Manager.getTime())
    end

    local moneyLabel = Instance.new("Textlabel")
    moneyLabel.text = "Money:0"
    moneyLabel:setPos(0,50)
    moneyLabel:setSize(125,50)
    moneyLabel.limit = 125
    moneyLabel.font = fontSmall
    moneyLabel.textColor = colorTheme.titleColor
    moneyLabel.update = function()
        moneyLabel.text = string.format("Money:$%.2f",Manager.getMoney())
    end

    local multLabel = Instance.new("Textlabel")
    multLabel.text = "Mult:"
    multLabel:setPos(0,100)
    multLabel:setSize(125,50)
    multLabel.limit = 125
    multLabel.font = fontSmall
    multLabel.textColor = colorTheme.titleColor
    multLabel.update = function()
        multLabel.text = string.format("Mult:%.2f",testUpgrade.trigger(1))
    end


    local cloneLabel = Instance.Clone(multLabel)
    cloneLabel.update = function()
        cloneLabel.text = string.format("Mult:%.2f",testUpgrade.trigger(1))
    end
    cloneLabel:setPos(0,150)

    local panel = {titleLabel,underTitleLabel,startButton}
    local gamePanel = {testLabel,timeLabel,sellButton,moneyLabel,buyButton,multLabel,cloneLabel}

    GuiController.createGUI("title",panel)
    GuiController.createGUI("game",gamePanel)
    GuiController.loadGUI("title")

    


end

function love.mousepressed(x, y, mouseButton, istouch, presses)
    Button.mousepressed(x,y,mouseButton,istouch,presses)
end


function love.update()
    Manager.update()
    GuiController.updateAll()
end

function love.draw() -- Needs to be replaced with other stuff. Probably a game handler. Something that can switch stuff around. Like from main menu to game.
    love.graphics.setColor(theme.backgroundColor)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    GuiController.drawAll()
end


local Coins = {}
local Player = require("player")

function Coins:load()
    listOfCoins = {}

    --creates Coins from tiled
    self:create()
end

function Coins:create()
    if gameMap.layers["coins"] then
        local coinImage = love.graphics.newImage("assets/coin.png") --coin image
        for i, obj in ipairs(gameMap.layers["coins"].objects) do
            local coin = {}
            coin.sprite = coinImage
            --centers coins hitbox
            local centerX = obj.x + (obj.width / 2)
            local centerY = obj.y + (obj.height / 2)
            --coin physics values
            coin.physics = {}
            coin.physics.body = love.physics.newBody(world, centerX, centerY, "static")
            coin.physics.body:setFixedRotation(true)
            coin.physics.shape = love.physics.newRectangleShape(obj.width, obj.height)
            coin.physics.fixture = love.physics.newFixture(coin.physics.body, coin.physics.shape)
            coin.physics.fixture:setSensor(true)
            coin.physics.fixture:setUserData(coin)
            --puts coins in listOfCoins table
            table.insert(listOfCoins, coin)
        end
    end
end

function Coins:update(dt)
    --removes collected coin
    for i = #listOfCoins, 1, -1 do
        local coin = listOfCoins[i]
        if coin.destroyed then
            if coin.physics and coin.physics.body and not coin.physics.body:isDestroyed() then
                coin.physics.body:destroy()
            end
            table.remove(listOfCoins, i)
        end
    end
end

function Coins:removeAll()
    for i, coin in ipairs(listOfCoins) do
        coin.physics.body:destroy()
    end
    listOfCoins = {}
end

function Coins:draw()
    --draws coins from listOfCoins
    for i, coin in ipairs(listOfCoins) do
        local cx, cy = coin.physics.body:getPosition()
        local sw = coin.sprite:getWidth()
        local sh = coin.sprite:getHeight()
        love.graphics.draw(coin.sprite, cx, cy, 0, 1, 1, sw / 2, sh / 2)
    end
end

function Coins:beginContact(a, b, collision)
    local nameA = a:getUserData()
    local nameB = b:getUserData()

    --checks if player hit coin to remove
    if (nameA == "player" and type(nameB) == "table") then
        nameB.destroyed = true
        print("coin collected")
    elseif (nameB == "player" and type(nameA) == "table") then
        nameA.destroyed = true
        print("coin collected")
    end
end






return Coins

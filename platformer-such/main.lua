love.graphics.setDefaultFilter("nearest", "nearest")
local Menu = require("menu_button")
local Player = require("player")
local Solids = require("solids")
local Coins = require("coins")
local Rain = require("rain")
local Map = require("map")




function love.load()
    gameWindow = {}
    gameWindow.width, gameWindow.height = love.graphics.getDimensions()
    Menu:load()
    Map:load()
    Player:load()
    Solids:load()
    Coins:load()
    Rain:load()
end

function love.update(dt)
    Menu:update(dt)
    Map:update(dt)
    world:update(dt)
    Player:update(dt)
    Coins:update(dt)
    Rain:update(dt)
end

function checkGameWindowValues()

end

function love.draw()
    Menu:draw()
    love.graphics.push()
    love.graphics.scale(2, 2)
    Map:draw()
    Player:draw()
    Coins:draw()
    Rain:draw()
    love.graphics.pop()
end

function love.keypressed(key)
    Player:keypressed(key)
end

function love.mousepressed(x, y, mouseButton, istouch)
    Menu:mousepressed(x, y, mouseButton, istouch)
end

function beginContact(a, b, collision)
    Player:beginContact(a, b, collision)
    Coins:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    Player:endContact(a, b, collision)
end

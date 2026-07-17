local Map = {}
local Solids = require("solids")
local Coins = require("coins")
sti = require("libraries/sti")

function Map:load()
    self.currentLevel = 1 --loads in first level
    self.maxLevels = 2 --amount of levels
    world = love.physics.newWorld(0, 800, true)
    world:setCallbacks(beginContact, endContact)
    self:init()
end

function Map:init()
    gameMap = sti("maps/" .. self.currentLevel .. ".lua")
    --hides hitboxes for stuff on gob
    gameMap.layers.solids.visible = false
    gameMap.layers.coins.visible = false
end

function Map:change()
    if self.currentLevel < self.maxLevels then
        self:delete()
        self.currentLevel = self.currentLevel + 1
        self:init()
        Coins:create()
        Solids:create()
    else
        self:delete()
        self.currentLevel = 1
        self:init()
        Coins:create()
        Solids:create()
    end
end

function Map:delete()
    Solids:removeAll() --removes current solids
    Coins:removeAll() --removes current coins
end

function Map:update(dt)

end

function Map:draw()
    gameMap:draw(0, 0, 2, 2) --scales map by 200%
end


return Map

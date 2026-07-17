local Player = {}


function Player:load()
    --player values
    self.x = 20
    self.y = 100
    self.width = 20
    self.height = 60
    self.speed = 800
    self.maxSpeed = 180
    self.jump = -520
    self.grounded = false

    --makes player hitbox center
    local centerX = self.x + (self.width / 2)
    local centerY = self.y + (self.height / 2)

    --player physics values
    self.physics = {}
    self.physics.body = love.physics.newBody(world, centerX, centerY, "dynamic")
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
    self.physics.fixture:setUserData("player")
end




--function for player movement
function Player:movement()
    local px, py = self.physics.body:getLinearVelocity()
    --makes player go right
    if love.keyboard.isDown("d", "right") and px < self.maxSpeed then
        self.physics.body:applyForce(self.speed, 0)
    end
    --makes player go left
    if love.keyboard.isDown("a", "left") and px > -self.maxSpeed then
        self.physics.body:applyForce(-self.speed, 0)
    end
end

--makes player jump
function Player:keypressed(key)
    if key == "space" and self.grounded == true then
        self.physics.body:applyLinearImpulse(0, self.jump)
    end
end



function Player:update(dt)
    --handles player movement
    self:movement()
    --syncs player physics with player position
    self:syncPhysics()
end

function Player:syncPhysics()
    --matches player with physics body
    self.x, self.y = self.physics.body:getPosition()
end

function Player:draw()
    --draws player
    local drawX = self.x - (self.width / 2)
    local drawY = self.y - (self.height / 2)

    love.graphics.rectangle("fill", drawX, drawY, self.width, self.height)

    if self.grounded == true then
        love.graphics.print("grounded", drawX, drawY - 30)
    end
end

function Player:beginContact(a, b, collision)
    local nameA = a:getUserData()
    local nameB = b:getUserData()

--checks player if hes grounded to make sure he can jump
    if (nameA == "player" and nameB == "solid") or (nameA == "solid" and nameB == "player") then
        local nx, ny = collision:getNormal()
        if a == self.physics.fixture and ny > 0 then
            self.grounded = true
        elseif b == self.physics.fixture and ny < 0 then
            self.grounded = true
        end
    end
end

function Player:endContact(a, b, collision)
    local nameA = a:getUserData()
    local nameB = b:getUserData()

    --tells game player isnt touching the ground anymore
    if (nameA == "player" and nameB == "solid") or (nameA == "solid" and nameB == "player") then
        self.grounded = false
    end
end




return Player

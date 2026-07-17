local Solids = {}

function Solids:load()
    listOfSolids = {}
    self:create()
end

 --creates solids for platforms
function Solids:create()
    if gameMap.layers["solids"] then
        for i, obj in ipairs(gameMap.layers["solids"].objects) do
            local solid = {}

            --centers solids hitbox
            local centerX = obj.x + (obj.width / 2)
            local centerY = obj.y + (obj.height / 2)

            --solids physics values
            solid.physics = {}
            solid.physics.body = love.physics.newBody(world, centerX, centerY, "static")
            solid.physics.body:setFixedRotation(true)
            solid.physics.shape = love.physics.newRectangleShape(obj.width, obj.height)
            solid.physics.fixture = love.physics.newFixture(solid.physics.body, solid.physics.shape)
            solid.physics.fixture:setUserData("solid")

            --puts solids in listOfSolids table
            table.insert(listOfSolids, solid)
        end
    end
end

--removes all solids
function Solids:removeAll()
    for i, solid in ipairs(listOfSolids) do
        solid.physics.body:destroy()
    end
    listOfSolids = {}
end


return Solids

local Rain = {}


function Rain:load()
    listOfRain = {}

    for i = 1, 200 do
            --rain values
            local rain = {
            x = math.random(0, gameWindow.width),
            y = math.random(-10, gameWindow.height),
            speed = math.random(200, 600)
        }

        table.insert(listOfRain, rain)
    end
end

function Rain:update(dt)
    for i, rain in ipairs(listOfRain) do
        rain.y = rain.y + (rain.speed * dt)
        if rain.y > gameWindow.height then
            rain.y = -10
            rain.x = math.random(0, gameWindow.width)
        end
    end
end

function Rain:draw()
    love.graphics.setColor(0, 0, 1)
    for i, rain in ipairs(listOfRain) do
        love.graphics.line(rain.x, rain.y, rain.x, rain.y + 10)
    end
    love.graphics.setColor(1, 1, 1)
end

return Rain

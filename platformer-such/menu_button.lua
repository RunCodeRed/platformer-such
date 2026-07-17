local Menu = {}
local Map = require("map")

--checks if mouse is over something
local function CheckHover(mx,my,rectx,recty,rectw,recth)
  return mx < rectx + rectw and
     rectx < mx and
     my < recty + recth and
     recty < my
end

--button values
local button = {
    x = 1060,
    y = 15,
    width = 209,
    height = 80,
    isHovered = false
}

--load in different font sizes
function Menu:load()
    normalFont = love.graphics.newFont()
    largeFont = love.graphics.newFont(30)
end

function Menu:update(dt)
    local mouseX, mouseY = love.mouse.getPosition() --gets mouse position
    button.isHovered = CheckHover(mouseX, mouseY, button.x, button.y, button.width, button.height) --checks if mouse is over button
end

function Menu:draw()
    --debugging and such
    local mx, my = love.mouse.getPosition() --gets mouse position
    love.graphics.print("Mouse X:" .. mx, 10, 10) --prints mouse x cords
    love.graphics.print("Mouse Y:" .. my, 10, 30) --prints mouse y cords

    if button.isHovered then
        love.graphics.setColor(1, 0, 0.5) --highlights button if hovered
    else
        love.graphics.setColor(1, 1, 0) --makes button normal color
    end

    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height) --draws button

    love.graphics.setFont(largeFont) --makes font large
    love.graphics.setColor(0, 1, 1) --makes text on button blue
    love.graphics.print("Switch Level", button.x, button.y, 0, 1, 1, -10, -25) --draws text
    love.graphics.setFont(normalFont) --sets font back to normal
    love.graphics.setColor(1, 1, 1) --makes font normal color
end

function Menu:mousepressed(x, y, mouseButton, istouch)
    if mouseButton == 1 then
        if button.isHovered then
            Map:change() --changes map
            print("level changed")
        end
    end
end

return Menu

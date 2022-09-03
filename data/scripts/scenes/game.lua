
function gameReload()

    player = newPlayer(400, 300)

    rooms = generate()

    BACKGROUND = love.graphics.newCanvas(WS[1], WS[2])
    FOREGROUND = love.graphics.newCanvas(WS[1], WS[2])

    playerBullets = {}
    
end

function gameDie()
    
end

function game()
    
    -- Reset
    sceneAt = "game"
    
    setColor(255, 255, 255)
    clear(155, 155, 155)

    love.graphics.setCanvas(BACKGROUND)
    clear(255, 157, 129)

    for id, room in ipairs(rooms) do room:drawBg() end

    love.graphics.setCanvas(FOREGROUND)
    clear(0, 0, 0, 0)

    for id, bullet in ipairs(playerBullets) do

        bullet.x = bullet.x + bullet.vel.x * dt
        bullet.y = bullet.y + bullet.vel.y * dt

        bullet:process()

    end

    player:process()
    player:draw()

    roomAt = math.floor(player.pos.y / WS[2])
    bindCamera(WS[1] * 0.5, roomAt * WS[2] + WS[2] * 0.5, 1)

    for id, room in ipairs(rooms) do room:drawFg() end

    love.graphics.setCanvas(display)

    love.graphics.draw(BACKGROUND)

    love.graphics.setShader(SHADERS.SHADOW)
    --love.graphics.draw(FOREGROUND, -8, 8)
    love.graphics.setShader()

    love.window.setTitle(love.timer.getFPS())

    love.graphics.draw(FOREGROUND)

    if justPressed("space") then shock(WS[1] * 0.5, WS[2] * 0.5, 0.5, 0.1, 2) end

    -- Return scene
    return sceneAt
end
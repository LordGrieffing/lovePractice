function love.load()
    Player = {}
    Player.x = 400
    Player.y = 200
    Player.speed = 3
end

function love.update(dt)
    if love.keyboard.isDown("right") then
        Player.x = Player.x + Player.speed
    end

    if love.keyboard.isDown("left") then
        Player.x = Player.x - Player.speed
    end

    if love.keyboard.isDown("up") then
        Player.y = Player.y - Player.speed
    end

    if love.keyboard.isDown("down") then
        Player.y = Player.y + Player.speed
    end

    if love.keyboard.isDown("lshift") then
        Player.speed = 6
    else
        Player.speed = 3
    end

end

function love.draw()
    love.graphics.circle("fill", Player.x, Player.y, 15)
end
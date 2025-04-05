_G.love = require("love")

love.graphics.setFont (love.graphics.newFont(25))
Font = love.graphics.getFont()
LifeScoreText = love.graphics.newText(Font)

function love.load()
    Player = {}
    Player.x = 400
    Player.y = 200
    Player.speed = 3
    Player.score = 0
    Player.boost = 200

    Astroid = {}
    Astroid.x = 600
    Astroid.y = math.random(10, 800)
    Astroid.speed = 10

    StarField = {}

    GameState = false
end

function love.update(dt)

    if GameState == true then
        return
    end
    -- Generate background
    for i = 0, 101, 1
    do 
        StarField[i] = math.random(10, 800)
        StarField[i+1] = math.random(10, 800)
    end

    -- Player movement is handled here
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
        if Player.boost > 0 then
            Player.speed = 6
            Player.boost = Player.boost - 5
            if Player.boost < 0 then
                Player.boost = 0
            end
        else
            Player.speed = 3
        end

    else
        Player.speed = 3

        if Player.boost <= 200 then
            Player.boost = Player.boost + 1
        end
    end


    -- Astroid movement is handled here
    Astroid.x = Astroid.x - Astroid.speed

    if Astroid.x < 0 then
        Astroid.x = 600
        Astroid.y = math.random(10, 800)
        Astroid.speed = Astroid.speed + 0.5
    end

    -- Handle the background movement here
    for i = 0,101,2
    do
        StarField[i] = StarField[i] - 2
    end

    -- Player score and analytics
    Player.score = Player.score + 10
    LifeScoreText:set({{1,1,1}, tostring(Player.score)}, 0, 0)


    -- Handle Player collisions
    GameState = CheckCircleCollision(Player.x, Player.y, 5, Astroid.x, Astroid.y, 30)



end

function love.draw()
    if GameState == true then
        love.graphics.setColor(0,1,0)
        love.graphics.setFont (love.graphics.newFont(100))
        Font = love.graphics.getFont()
        GameOver = love.graphics.newText(Font)
        GameOver:set({{0,1,0}, "GAME OVER"}, 0, 0)
        love.graphics.draw(GameOver, 120, 200)

    end

    love.graphics.setColor(0,1,0)
    love.graphics.draw(LifeScoreText, 10, 10)
    love.graphics.polygon("fill", 150, 10, 150 + Player.boost, 10, 150 + Player.boost, 30, 150, 30)
    love.graphics.setColor(1,1,1)
    love.graphics.points(StarField)
    love.graphics.polygon("fill", (Player.x-10), (Player.y-5),(Player.x+5), (Player.y+5),(Player.x-10), (Player.y+10))
    love.graphics.setColor(0.5,0.5,0.6)
    love.graphics.circle("fill", Astroid.x, Astroid.y, 30)
end

function CheckCircleCollision(x1, y1, r1, x2, y2, r2)
    local dx = x1 - x2
    local dy = y1 - y2
    local distance = math.sqrt(dx * dx + dy * dy)
    return distance < (r1 + r2)
end
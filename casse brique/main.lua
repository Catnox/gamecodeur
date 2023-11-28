io.stdout:setvbuf("no")

if arg[#arg] == "-debug" then
    require("mobdebug").start()
end

local pad = {x = 0, y = 0, largeur = 80, hauteur = 20}

local balle = {x = 0, y = 0, rayon = 10, colle = false, vx = 0, vy = 0}

function start()
    balle.colle = true
end

function love.load()
    largeur = love.graphics.getWidth()
    hauteur = love.graphics.getHeight()

    pad.y = hauteur - pad.hauteur

    start()
end

function love.update(dt)
    pad.x = love.mouse.getX()

    if balle.colle == true then
        balle.x = pad.x
        balle.y = pad.y - balle.rayon
    else
        balle.x = balle.x + (balle.vx * dt)
        balle.y = balle.y + (balle.vy * dt)
    end

    if balle.x > largeur - balle.rayon then
        balle.vx = -balle.vx
        balle.x = largeur - balle.rayon
    end

    if balle.x < 0 then
        balle.vx = -balle.vx
        balle.x = 0 + balle.rayon
    end

    if balle.y - balle.rayon < 0 then
        balle.vy = -balle.vy
        balle.y = 0 + balle.rayon
    end

    if balle.y > hauteur - balle.rayon * 2 then
        start()
    end

    if
        balle.y - balle.rayon <= pad.y and balle.y - balle.rayon > pad.x - pad.largeur / 2 and
            balle.x < pad.x + pad.largeur / 2
     then
        balle.vy = -balle.vy
        balle.y = hauteur + pad.hauteur - balle.rayon
    end
end

function love.draw()
    love.graphics.rectangle("fill", pad.x - (pad.largeur / 2), pad.y, pad.largeur, pad.hauteur)
    love.graphics.circle("fill", balle.x, balle.y, balle.rayon)
end

function love.mousepressed(x, y, n)
    if balle.colle == true then
        balle.colle = false
        balle.vx = 200
        balle.vy = -200
    end
end

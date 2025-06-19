--------------------- CONTROLLERS -----------------------


-- Keybind and moving

function moveRight(dt) -- fonction pour se déplacer à droite
    player.posX = player.posX + player.speed * dt
end

function moveLeft(dt) -- fonction pour se déplacer à gauche
    player.posX = player.posX - player.speed * dt
end

function jump() -- fonction pour sauter
    if not player.isJumping and not showMessage then
        player.velocityY = player.jumpForce
        player.isJumping = true
    end
end



function updateControllers(dt)
    if not showMessage then
        if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
                moveRight(dt)
        elseif love.keyboard.isDown("left") or love.keyboard.isDown("q") then
                moveLeft(dt)
        elseif love.keyboard.isDown("space") or love.keyboard.isDown("z") then
                jump(dt)
        end
    end
end 

 -- Gestion du déplacement du joueur
 
function love.keypressed(key)
    if scene == "game" then
        if key == "right" then
            moveRight(love.timer.getDelta())
        elseif key == "left" then
            moveLeft(love.timer.getDelta())
        elseif key == "space" then
            jump(love.timer.getDelta())
        end
    end
end


-- gère les bouttons des menues
function love.mousepressed(x, y, button)
    if scene == "menu1" then
        menu1.mousepressed(x, y, button)
    elseif scene == "menu2" then
        menu2.mousepressed(x, y, button)
    elseif scene == "menu3" then
        menu3.mousepressed(x, y, button)
    end
end
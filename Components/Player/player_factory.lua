---------------------- PLAYER FACTORY ------------------------


require "Components/Player/player_config"
require "settings"




function updatePlayer(dt)

    -- Appliquer l'effet de boucle horizontal
    if player.posX > love.graphics.getWidth() then
        player.posX = -player.width
    elseif player.posX < -player.width then
        player.posX = love.graphics.getWidth()
    end

        ------------------------------------------------------------------------------------------------
    -- GESTION MORT DU PERSONNAGE
    for j, bird in ipairs(oiseaux) do
        if checkCollision(bird.x, bird.y, oiseau.frameWidth, oiseau.frameHeight, player.posX, player.posY, player.width, player.height) then
            table.remove(oiseaux, j)
            showMessage = true -- affiche le message de mort
            messageTimer = 1  -- temps du message
            scrollSpeed = 100 -- réintialise scrollspeed
            oiseau.maximum = 1
            affiche_message_level = false
            
            if musicPlaying then
                music:stop()  -- Arrêtez la musique si elle est en cours de lecture
            end
        end
    end

    if showMessage then
        messageTimer = messageTimer - dt
        if messageTimer <= -1 then
            showMessage = false 
            player.posX = love.graphics.getWidth() / 2 - player.width / 2 -- Remets la position du personnage 
            scene = "menu1"
            Level = 0  -- remet le niveau a 0
            carrotes.recup = 0 -- reintialise le score de carrote
            music:play()  -- Relancez la musique
            musicPlaying = true

            love.load()
        end
    end
    -- GESTION COLLISION/GRAVITE/RESPAWNS + GESTION ARBRES & NUAGE
    ------------------------------------------------------------------------------------------
        -- Gestion de gravité
        player.velocityY = player.velocityY + player.gravity * dt
        player.posY = player.posY + player.velocityY * dt

        -- Gestion des collisions avec le sol
        if player.posY > love.graphics.getHeight() - blockHeight - player.height then
            player.posY = love.graphics.getHeight() - blockHeight - player.height
            player.velocityY = 0
            player.isJumping = false
        end


 end 

function updateDeath()
    -- Dessinez le joueur + gère le message de la mort
    love.graphics.draw(player.img, player.posX, player.posY)
    if showMessage then
    love.graphics.setColor(1, 0, 0)  -- Couleur du texte
    love.graphics.setFont(font)
    love.graphics.print("GAME OVER", 460, 300)
    love.graphics.print("You were caught by a bird!", 375, 400)
    end 
end 
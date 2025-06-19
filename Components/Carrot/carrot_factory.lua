---------------------- CARROT FACTORY ---------------------------


require "settings"
require "Components/Carrot/carrot_config"
require "Interface/collision"
require "Components/Player/player_config"

-- Fonction pour une nouvelle carotte
function spawnCarrot()
    if #carrotes < carrotes.maxCount then
    table.insert(carrotes, {
        x = love.graphics.getWidth(), -- Démarre depuis la droite de l'écran
        y = love.math.random(0, love.graphics.getHeight() - carrotes.img:getHeight()),
        scale = 0.3 -- Taille aléatoire
    })
    end 
end



function updateCarrot(dt)
    -- Gestion des carottes
    for i, car in ipairs(carrotes) do
        -- Déplacer la carotte vers la gauche puis reviens
        car.x = car.x - scrollSpeed * dt

        -- Réinitialiser la position de la carotte lorsqu'elle sort de l'écran
        if car.x < -carrotes.img:getWidth() then
            table.remove(carrotes, i)
            spawnCarrot() -- Générer une nouvelle carotte
        end 
        
    ----------------------------------------------------
    --  si le joueur entre en collision avec une carotte
    if checkCollision(player.posX, player.posY, player.width, player.height, car.x, car.y, carrotes.img:getWidth(), carrotes.img:getHeight()) then
        table.remove(carrotes, i)
        carrotes.recup = carrotes.recup + 1
        spawnCarrot() -- Générer une nouvelle carotte
        love.audio.play(sfx) -- Jouer l'effet sonore
    end

    -- si un oiseau entre en collision avec une carrotte
    for j, bird in ipairs(oiseaux) do
        if checkCollision(bird.x, bird.y, oiseau.frameWidth, oiseau.frameHeight, car.x, car.y, carrotes.img:getWidth(), carrotes.img:getHeight()) then
            table.remove(carrotes, i)
            spawnCarrot()
        end

    end
    end


end 


function drawCarrot()
    -- Dessine les carottes
    for i, car in ipairs(carrotes) do
        love.graphics.draw(carrotes.img, car.x, car.y, 0, car.scale)
    end

end 
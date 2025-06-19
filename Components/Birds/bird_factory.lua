require "Components/Birds/bird_config"

require "settings"


-------------------- BIRD FACTORY -------------------------

-- Fonction pour un nouvel oiseau
function spawnOiseau()
    if #oiseaux < oiseau.maximum and not showMessage then  -- Vérifiez le nombre d'oiseaux avant d'en ajouter un nouveau
        local startX = love.math.random(-0, -2000)-- Démarre depuis la gauche de l'écran
        local startY = love.math.random(0, 550)
        table.insert(oiseaux, {
            x = startX,
            y = startY,
            startX = startX, -- Position initiale X de l'oiseau
            startY = startY, -- Position initiale Y de l'oiseau
            scale = 2, -- Agrandir l'oiseau
            animTimer = 0,
            frame = 1
        })
    end
end


function updateOiseau(dt)
    
    -- Gestion des oiseaux
    for i, bird in ipairs(oiseaux) do
        bird.x = bird.x + scrollSpeed * dt  -- Ajustez la position x pour se déplacer vers la droite
        bird.animTimer = bird.animTimer - dt
        if bird.animTimer <= 0 then
            bird.animTimer = 0.1
            bird.frame = bird.frame + 1    -- ajoute au quade, on passe a l'image suivant (image a + 1 -> image b)
            if bird.frame > oiseau.max_frame then
                bird.frame = 1
            end
        end
        if bird.x > love.graphics.getWidth() then
            table.remove(oiseaux, i)
            spawnOiseau()

        if oiseau.maximum > 1 then 
            spawnOiseau()
        end 
        elseif bird.x < -oiseau.frameWidth then
            table.remove(oiseaux, i)
            bird.x = bird.startX -- Réinitialisez la position X à gauche
            bird.y = bird.startY -- Réinitialisez la position Y à sa position initiale Y
            spawnOiseau()
        end
    end
end




function drawOiseau()
    -- Dessine les oiseaux
    for i, bird in ipairs(oiseaux) do
        local birdQuad = love.graphics.newQuad((bird.frame - 1) * 32, oiseau.Yline, 32, 32, oiseau.sprite_sheet:getDimensions())
        love.graphics.draw(oiseau.sprite_sheet, birdQuad, bird.x, bird.y, 0, bird.scale)
    end   

end 
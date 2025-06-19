-- require et variables
require "Interface/collision"
require "Components/Birds/bird_config"
require "Components/Birds/bird_factory"

require "Components/Environment/assets_config"
require "Components/Environment/assets_factory"

require "Components/Player/player_factory"
require "Components/Player/player_config"

require "Components/Carrot/carrot_config"
require "Components/Carrot/carrot_factory"


require "Interface/controllers"
require "settings"



-- GESTION CHARGEMENT, MUSIQUE & SPAWNES
---------------------------------------------------------------------------------------------------------
-- oiseaux = OiseauxFactory:new()

function love.load()
    
    love.graphics.setFont(font)
    music:setVolume(0.5)-- règle le son de la musique
    music:setLooping(true) -- Boucle le sons de la musique
    music:play()
    -- Créez les carottes initiales
    for i = 1, carrotes.maxCount do
        spawnCarrot()
    end
    spawnOiseau()
    menu1.load()
    menu2.load()
    menu3.load()
end


-- GESTION MOUVEMENT
---------------------------------------------------------------------------------------------------------

function love.update(dt)

    if scene == "game" then     
    
    -- \!/ Appelle des fonctions des factory-- \!/

    updateOiseau(dt)

    updatePlayer(dt)

    updateControllers(dt)

    updateAssets(dt)

    updateCarrot(dt)

    optimisation()

    updateDifficulty(dt)
    
    end

end

-- GRAPHISME/AFFICHAGE/LE DESSIN
-------------------------------------------------------------------------------------------------------------
function love.draw()
    if scene == "game" then

        -- dessine les éléments --
        drawAssets()

        drawOiseau()

        updateDeath()

        drawCarrot()


    end 

    drawMenu() -- laisser hors du statement

end 



-- Made by Louloubiwan, Hugo Gillot Fallone
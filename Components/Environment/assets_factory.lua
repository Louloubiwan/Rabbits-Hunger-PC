
-------------- ASSETS FACTORY -----------------


require "settings"

require "Components/Carrot/carrot_factory"
require "Components/Environment/assets_config"



function updateAssets(dt)
    
    groundX = groundX - scrollSpeed * dt   -- Mets a jours le défilement du sol

     -------------------------------------------------------
    -- Gestion des arbres & Nuages
    cloudX = cloudX - 150 * dt
    if cloudX < -tree:getWidth() then  -- respawn l'arbre a gauche de l'écran.
        cloudX = 4200
    end

    cloud2X = cloud2X - 150 * dt
    if cloud2X < -tree:getWidth() then  -- respawn l'arbre a gauche de l'écran.
        cloud2X = 4200
    end
   
    -- Déplacer l'arbre'vers la gauche 
    treeX = treeX - scrollSpeed * dt
    if treeX < -tree:getWidth() then  -- respawn l'arbre a gauche de l'écran.
        treeX = 4500
    end
    -- Déplacer l'arbre2 vers la gauche 
    tree2X = tree2X - scrollSpeed * dt
    if tree2X < -tree:getWidth() then  -- respawn l'arbre a gauche de l'écran.
        tree2X = 4500
    end

end 



function drawAssets()

    -- AFFFICHAGE --

    -- Dessinez le fond
    love.graphics.draw(background)

    -- Dessines le nombres de carottes prises (uniquement la variable carrotes.recup)
    love.graphics.print(tostring(carrotes.recup), 80, 15)    

    -- Dessine l'image de la carotte
    love.graphics.draw(imageHautGauche, 10, 5, 0, 0.5, 0.5) -- X, Y, R

    -- Dessine le niveau.
    if difficulties == "hard" then
        love.graphics.print("Level:", 675, 80, 0, 0.8, 0.8)
        love.graphics.print(tostring(Level), 775, 80, 0, 0.8, 0.8) 
    end  


    -- Dessine le niveau de Difficultée ainsi que la couleurs de la difficultée.
    love.graphics.print("Difficulties:", 675, 30, 0, 0.8, 0.8)

    if difficulties == "hard" then 
        love.graphics.setColor(1, 0.3, 0)
    elseif difficulties == "medium" then 
        love.graphics.setColor(1, 0.8, 0)
    else love.graphics.setColor(0, 1, 0)

    end 
    love.graphics.print(tostring(difficulties), 860, 30, 0, 0.8, 0.8)
    love.graphics.setColor(1, 1, 1)


    love.graphics.push() -- mets la taille par defaut
    love.graphics.scale(0.3, 0.3) -- augmente la taille de l'image
    love.graphics.draw(cloud2, cloud2X, 400)
    love.graphics.draw(cloud, cloudX, 700)
    love.graphics.pop() -- remets l'image non afficher par défaut
    --Arbres 
    love.graphics.push() -- mets la taille par defaut
    love.graphics.scale(0.3, 0.3) -- diminue la taille de l'image
    love.graphics.draw(tree2, tree2X, 1100)
    love.graphics.draw(tree, treeX, 1100) -- affiche l'image
    love.graphics.pop() -- remets l'image non afficher par déffaut 


    -- Dessine le sole infinie --
    local x = groundX
    while x < love.graphics.getWidth() do
        love.graphics.draw(block, x, love.graphics.getHeight() - blockHeight)
        x = x + blockWidth
    end

end 
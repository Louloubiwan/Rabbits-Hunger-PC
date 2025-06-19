----------------------- SETTINGS -------------------------------


-- variable require pour les menues
scene = "menu1"
menu1 = require "Interface/menu1"
menu2 = require "Interface/menu2"
menu3 = require "Interface/menu3"

-- Global variables 
imageHautGauche = love.graphics.newImage("Library/carotte.png")
showMessage = false -- message  de mort
messageTimer = 3 -- le temps de l'affichage du message de mort
musicPlaying = true

-- Variable pour le level
affiche_message_level = false
LevelTimer = 10
Level = 0 
scrollSpeed = 100  -- la vitesse de défilement


-- The Font/audio
font = love.graphics.newFont("Library/autre/Archivo-Bold.ttf", 40)
sfx = love.audio.newSource("Library/autre/cronch.mp3", "static")
music = love.audio.newSource("Library/autre/MainTheme.mp3", "stream")




function updateDifficulty(dt)
    -- Gestion des difficultés --
    --------------------------------------------------------------------------------------------
    affiche_message_level = true -- l'affichage du niveau


    if difficulties == "hard" then 
        scrollSpeed = 220 

    elseif difficulties == "medium" then 
        scrollSpeed = 180
        oiseau.maximum = 2 

    elseif difficulties == "easy" then 
        scrollSpeed = 110
        oiseau.maximum = 1
    end 


    if difficulties == "hard" then 
        if affiche_message_level then 
            LevelTimer = LevelTimer - dt -- baisse du timer
            if LevelTimer <= 0 then 
                Level = Level + 1 -- passe au niveau sup
                oiseau.maximum = oiseau.maximum + 1 -- ajoute 1 oiseau a chaque niveau sup
                scrollSpeed = scrollSpeed + 20 -- augmente la vitesse a chaque niveau sup
                LevelTimer = 10 -- le timer avant le prochain niveau
            end 
        end 
    end
end 



function optimisation()

-- GESTION OPTIMISATION : DECHARGEMENT DE L'ECRAN
----------------------------------------------------------------------------------------------------
    -- Supprimer les carottes sorties de l'écran
    for i = #carrotes, 1, -1 do
        local car = carrotes[i]
        if car.x < -carrotes.img:getWidth() then
            table.remove(carrotes, i)
        end
    end

    -- Supprimer et libérer la mémoire des images de carotte sorties de l'écran
    for i, car in ipairs(carrotes) do
        if car.x < -carrotes.img:getWidth() then
            carrotes.img:release()
            table.remove(carrotes, i)
        end
    end

        -- Supprimer et libérer la mémoire de l'herbe sorti de l'écran
    local newBlockWidth = blockWidth * 0.5
    for i = #blocks, 1, -1 do
        local block = blocks[i]
        if block.x + newBlockWidth < 0 then
            table.remove(blocks, i)
            block.img:release()
        end
    end
end 



function updateMenu()
    
    -- Gestion des scènes
        if scene == "menu1" then
            menu1.update(dt)
        elseif scene == "menu2" then
            menu2.update(dt)
        elseif scene == "menu3" then
            menu3.update(dt)
        end
end 



function drawMenu()

    --GESTION MENU
    if scene == "menu1" then
        menu1.draw()
    elseif scene == "menu2" then
        menu2.draw()
    elseif scene == "menu3" then
        menu3.draw()
    end
end 
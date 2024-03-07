-- require et variables
require "collision"

-- L'Herbe
block = love.graphics.newImage("Library/Grass.jpg")
background = love.graphics.newImage("Library/background.jpg")
blockWidth = block:getWidth()
blockHeight = block:getHeight()
groundX = 0 -- Position initiale du sol
scrollSpeed = 100  -- la vitesse de défilement

-- The Font/audio
font = love.graphics.newFont("Library/autre/Archivo-Bold.ttf", 40)
sfx = love.audio.newSource("Library/autre/cronch.mp3", "static")
music = love.audio.newSource("Library/autre/MainTheme.mp3", "stream")

--Arbres & Nuages
tree = love.graphics.newImage("Library/tree.png")
treeX = 0
tree2 = love.graphics.newImage("Library/tree.png")
tree2X = 2000 
cloud = love.graphics.newImage("Library/Cloud.png")
cloudX = 0
cloud2 = love.graphics.newImage("Library/Cloud.png")
cloud2X = 2000

-- JOUEUR ET CARROTES UwU
-----------------------------------------------------------------------------------------
player = {}
player.speed = 300
player.jumpForce = -950  -- Force du saut (négative pour monter)    
player.gravity = 800    -- Gravité (positive pour descendre)
player.img = love.graphics.newImage("Library/rabbit.png")
player.width = player.img:getWidth()  -- Largeur du personnage
player.height = player.img:getHeight()  -- Hauteur du personnage
player.posX = 400  -- Position horizontale initiale
player.posY = love.graphics.getHeight() - blockHeight - player.height  -- Position verticale initiale
player.velocityY = 0  -- Vitesse verticale initiale
player.isJumping = false

oiseau = {}
oiseau.sprite_sheet = love.graphics.newImage("Library/32x32-bat-sprite.png")
oiseau.frameWidth = 32
oiseau.frameHeight = 32
oiseau.quad = love.graphics.newQuad(0, 0, oiseau.frameWidth, oiseau.frameHeight, oiseau.sprite_sheet:getDimensions())
oiseau.maximum = 1
oiseau.Yline = 32
oiseau.Anim_Timer = 0.1
oiseau.frame = 1
oiseau.max_frame = 3
oiseaux = {}  -- Table pour stocker les oiseaux

carrotes = {}  -- Table pour stocker les carottes
carrotes.maxCount = 2  -- Maximum de carottes à afficher
carrotes.img = love.graphics.newImage("Library/carotte.png")
carrotes.recup = 0

-- autre variables 
imageHautGauche = love.graphics.newImage("Library/carotte.png")
showMessage = false -- message  de mort
messageTimer = 3 -- le temps de l'affichage du message de mort
musicPlaying = true

-- Variable pour le level
affiche_message_level = false
LevelTimer = 20
Level = 0 

-- variable require pour les menues
 scene = "menu1"
 menu1 = require "menu1"
 menu2 = require "menu2"

-- GESTION CHARGEMENT, MUSIQUE & SPAWNES
---------------------------------------------------------------------------------------------------------

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
end

-- Fonction pour une nouvelle carotte
function spawnCarrot()
    if #carrotes < carrotes.maxCount then
    table.insert(carrotes, {
        x = love.graphics.getWidth(), -- Démarre depuis la droite de l'écran
        y = love.math.random(0, love.graphics.getHeight() - carrotes.img:getHeight()),
        scale = 0.3 -- Taille aléatoire
    })
end

-- Fonction pour un nouvel oiseau
function spawnOiseau()
    if #oiseaux < oiseau.maximum then  -- Vérifiez le nombre d'oiseaux avant d'en ajouter un nouveau
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

function moveRight(dt)
    player.posX = player.posX + player.speed * dt
end

function moveLeft(dt)
    player.posX = player.posX - player.speed * dt
end

function jump()
    if not player.isJumping and not showMessage then
        player.velocityY = player.jumpForce
        player.isJumping = true
    end
end

-- GESTION MOUVEMENT
---------------------------------------------------------------------------------------------------------

function love.update(dt)

       if scene == "game" then

    -- Mets a jours le défilement du sol
    groundX = groundX - scrollSpeed * dt

    -- optimisation du sole, si celui-ci sort de l'écran, sa évite d'en dessiner à l'infini
    if groundX < -block:getWidth() then
        groundX = 0
    end

    if not showMessage then
        if love.keyboard.isDown("right") then
                moveRight(dt)
        elseif love.keyboard.isDown("left") then
                moveLeft(dt)
        elseif love.keyboard.isDown("space") then
                jump(dt)
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

function love.keyreleased(key)
    if scene == "game" then
        if key == "right" or key == "left" then
            -- Arrêter le mouvement horizontal lorsque la touche est relâchée
        end
    end
end
-- GESTION DU SOLE & OISEAU, SPAWNES & LEVEL
----------------------------------------------------------------------------------------------------
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

-- Gestion des level
--------------------------------------------------------------------------------------------
    affiche_message_level = true -- l'affichage du niveau

    if affiche_message_level then 
        LevelTimer = LevelTimer - dt 
        if LevelTimer <= 0 then 
            Level = Level + 1 -- passe au niveau sup
            oiseau.maximum = oiseau.maximum + 1 -- ajoute 1 oiseau a chaque niveau sup
            scrollSpeed = scrollSpeed + 20 -- augmente la vitesse a chaque niveau sup
            LevelTimer = 20 -- le timer avant le prochain niveau
    end 
end
---------------------------------------------------------------------------------
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

-- Gestion des carottes
for i, car in ipairs(carrotes) do
    -- Déplacer la carotte vers la gauche puis reviens
    car.x = car.x - scrollSpeed * dt

    -- Réinitialiser la position de la carotte lorsqu'elle sort de l'écran
    if car.x < -carrotes.img:getWidth() then
        table.remove(carrotes, i)
        spawnCarrot() -- Générer une nouvelle carotte
    end

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
   -- Gestion des scènes
    elseif scene == "menu1" then
        menu1.update(dt)
    elseif scene == "menu2" then
        menu2.update(dt)
    end
end


-- GRAPHISME/AFFICHAGE/LE DESSIN
-------------------------------------------------------------------------------------------------------------
function love.draw()
     if scene == "game" then
    -- Dessinez le fond
    love.graphics.draw(background)

    -- Dessines le nombres de carottes prises (uniquement la variable carrotes.recup)
    love.graphics.print(tostring(carrotes.recup), 80, 15)    

    -- Dessine l'image de la carotte
    love.graphics.draw(imageHautGauche, 10, 5, 0, 0.5, 0.5) -- X, Y, R

    -- Dessine le niveau.
    love.graphics.print("Level", 500, 30)
    love.graphics.print(tostring(Level), 625, 30)  

    -- AFFFICHAGE ARBRES & NUAGES
    -- Nuages

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
    
    -- Dessine les carottes
    for i, car in ipairs(carrotes) do
        love.graphics.draw(carrotes.img, car.x, car.y, 0, car.scale)
    end

    -- Dessine les oiseaux
    for i, bird in ipairs(oiseaux) do
        local birdQuad = love.graphics.newQuad((bird.frame - 1) * 32, oiseau.Yline, 32, 32, oiseau.sprite_sheet:getDimensions())
        love.graphics.draw(oiseau.sprite_sheet, birdQuad, bird.x, bird.y, 0, bird.scale)
    end

    -- Dessine le sole infinie
    local x = groundX
    while x < love.graphics.getWidth() do
        love.graphics.draw(block, x, love.graphics.getHeight() - blockHeight)
        x = x + blockWidth
    end
    
    -- Dessinez le joueur + gère le message de la mort
    love.graphics.draw(player.img, player.posX, player.posY)
    if showMessage then
    love.graphics.setColor(1, 0, 0)  -- Couleur du texte
    love.graphics.setFont(font)
    love.graphics.print("GAME OVER", 460, 300)
    love.graphics.print("You were caught by a bird!", 375, 400)
end

--GESTION MENU + BOUTONS
--------------------------------------------------------------------------------------------------------
    elseif scene == "menu1" then
        menu1.draw()
    elseif scene == "menu2" then
        menu2.draw()
    end
end

 -- gère les bouttons des menues
function love.mousepressed(x, y, button)
    if scene == "game" then
    elseif scene == "menu1" then
        menu1.mousepressed(x, y, button)
    elseif scene == "menu2" then
        menu2.mousepressed(x, y, button)
    end
end
end 
-- Made by Louloubiwan, Hugo Gillot Fallone
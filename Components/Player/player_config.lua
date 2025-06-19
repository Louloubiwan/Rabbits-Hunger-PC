require "Components/Environment/assets_config"


-- JOUEUR UwU
-----------------------------------------------------------------------------------------
player = {}
player.speed = 300
player.jumpForce = -950  -- Force du saut (négative pour monter)    
player.gravity = 800    -- Gravité (positive pour descendre)
player.img = love.graphics.newImage("Library/rabbit.png")
player.width = player.img:getWidth()  -- Largeur du personnage
player.height = player.img:getHeight()  -- Hauteur du personnage
player.posX = 500  -- Position horizontale initiale
player.posY = love.graphics.getHeight() - blockHeight - player.height  -- Position verticale initiale
player.velocityY = 0  -- Vitesse verticale initiale
player.isJumping = false

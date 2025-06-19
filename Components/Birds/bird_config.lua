

-- DATA DES OISEAUX
-----------------------------------------------------------------------------

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
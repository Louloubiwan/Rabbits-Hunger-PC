local menu1 = {}  -- Créez une table locale pour stocker les fonctions du module

local buttons = {}  -- Déclarez la table locale pour stocker les boutons

function menu1.load()
    txt = {}
    txt.title = "The Rabbit's Hunger"
    txt.msg = "Made by Louloubiwan"
  
    FondEcran = love.graphics.newImage("Library/BG.jpg")
    -----------------------------------------------------------

    buttons.play = {x = 500, y = 300, width = 200, height = 80}
    buttons.exit = {x = 500, y = 600, width = 200, height = 80}
    buttons.about = {x = 500, y = 450, width = 200, height = 80}
end

function menu1.update(dt)

end

function menu1.draw()
    love.graphics.draw(FondEcran, -20, -100)
    love.graphics.print(txt.title, 450, 40, 0)
    love.graphics.print(txt.msg, 500, 120, 0, 0.6, 0.6)
    love.graphics.setColor(0, 0, 1) -- Blue color for play button
    love.graphics.rectangle("fill", buttons.play.x, buttons.play.y, buttons.play.width, buttons.play.height)
    love.graphics.setColor(0, 1, 0) -- Red color for exit button
    love.graphics.rectangle("fill", buttons.about.x, buttons.about.y, buttons.about.width, buttons.about.height)
    love.graphics.setColor(1, 1, 1) -- White color for text
    love.graphics.setColor(1, 0, 0) -- Blue color for about button
    love.graphics.rectangle("fill", buttons.exit.x, buttons.exit.y, buttons.exit.width, buttons.exit.height)
    love.graphics.setColor(1, 1, 1) -- White color for text
    love.graphics.print("Play", buttons.play.x + 50, buttons.play.y + 20)
    love.graphics.print("About", buttons.about.x + 40, buttons.about.y + 20)
    love.graphics.print("Exit", buttons.exit.x + 55, buttons.exit.y + 20)
end

function menu1.mousepressed(x, y, button)
    if button == 1 then -- Left mouse button
        if x >= buttons.play.x and x <= buttons.play.x + buttons.play.width and
           y >= buttons.play.y and y <= buttons.play.y + buttons.play.height then
            scene = "game"
            love.load()
        elseif x >= buttons.exit.x and x <= buttons.exit.x + buttons.exit.width and
               y >= buttons.exit.y and y <= buttons.exit.y + buttons.exit.height then
            love.event.quit()
        elseif x >= buttons.about.x and x <= buttons.about.x + buttons.about.width and
               y >= buttons.about.y and y <= buttons.about.y + buttons.about.height then
            scene = "menu2"
            love.load()
        end
    end
end


return menu1  -- Retournez la table locale contenant les fonctions du module

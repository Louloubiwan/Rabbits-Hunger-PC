local menu2 = {}



function menu2.load()
    backButton = {x = 40, y = 10, width = 150, height = 50}
    FondEcran = love.graphics.newImage("Library/BG.jpg")
end

function menu2.update(dt)

end

function menu2.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(FondEcran, -20, -100)
    love.graphics.setColor(1, 1, 1) -- White color for text
    love.graphics.setColor(0,0, 0)
    love.graphics.print("Press space to jump and use arrows to move back/forward", 235, 250, 0, 0.8, 0.8)
    love.graphics.print("escape the bats and eat as many carrots as you can !", 235, 300, 0, 0.8, 0.8)
    love.graphics.setColor(0.1,0.2, 1)
    love.graphics.print("CREDIT : ", 235, 400, 0, 0.7, 0.7)
    love.graphics.print("- Brain Nectar (Painted Tree)", 235, 435, 0, 0.7, 0.7)
    love.graphics.print("- Synethic223 (Cloud pack)", 235, 470, 0, 0.7, 0.7)
    love.graphics.print("- bagzie (Bat sprite)", 235, 505, 0, 0.7, 0.7)
    love.graphics.print("- palomaironique (carrots design)", 235, 540, 0, 0.7, 0.7)
    love.graphics.print("- Kenney (Rabbit's Disign)", 235, 575, 0, 0.7, 0.7)
    love.graphics.print("- iB3n [benji] (Sound Design)", 235, 615, 0, 0.7, 0.7)
    love.graphics.print("made by Louloubiwan, project start on the 13/08/2023", 235, 660, 0, 0.8, 0.8)
    love.graphics.setColor(1, 0.3, 0)
    love.graphics.rectangle("fill", backButton.x, backButton.y, backButton.width, backButton.height)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Back", backButton.x + 10, backButton.y + 5)
end

function menu2.mousepressed(x, y, button)
    if button == 1 then -- Left mouse button
        if x >= backButton.x and x <= backButton.x + backButton.width and
           y >= backButton.y and y <= backButton.y + backButton.height then
            scene = "menu1"
            love.load()
        end
    end
end

return menu2

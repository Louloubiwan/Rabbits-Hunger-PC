-- Menu3 = menue des choix des difficultés

local menu3 = {}



function menu3.load()

    backButton = {x = 20, y = 12, width = 150, height = 50}
    FondEcran = love.graphics.newImage("Library/BG.jpg")

    buttonEasy = {x = 200, y = 300, width = 200, height = 80}
    buttonMedium = {x = 500, y = 300, width = 200, height = 80}
    buttonHard = {x = 800, y = 300, width = 200, height = 80}


end 



function menu3.update(dt)

end


function menu3.draw()

	-- Récupère les dimensions de la fenêtre
	local windowWidth, windowHeight = love.graphics.getWidth(), love.graphics.getHeight()



	love.graphics.setColor(1, 1, 1)
    love.graphics.draw(FondEcran, -250, -100)

    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("fill", buttonEasy.x, buttonEasy.y, buttonEasy.width, buttonEasy.height)
    love.graphics.setColor(1, 0.8, 0)
    love.graphics.rectangle("fill", buttonMedium.x, buttonMedium.y, buttonMedium.width, buttonMedium.height)
    love.graphics.setColor(1, 0.2, 0)
    love.graphics.rectangle("fill", buttonHard.x, buttonHard.y, buttonHard.width, buttonHard.height)

    love.graphics.setColor(1, 0.3, 0)
    love.graphics.rectangle("fill", backButton.x, backButton.y, backButton.width, backButton.height)
    
    -- Les affichages des lettres des bouttons
    love.graphics.setColor(0.4, 0.4, 0.4)
    love.graphics.print("Easy", buttonEasy.x + 25, buttonEasy.y + 20)
    love.graphics.print("Medium", buttonMedium.x + 15, buttonMedium.y + 20)
    love.graphics.print("Hard", buttonHard.x + 25, buttonHard.y + 20)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Back", backButton.x + 10, backButton.y + 5)
end

function menu3.mousepressed(x, y, button)
    if button == 1 then -- clique gauche souris 
        if x >= backButton.x and x <= backButton.x + backButton.width and
           y >= backButton.y and y <= backButton.y + backButton.height then
            scene = "menu1"
            love.load()
        end 
    end 

    if button == 1 then -- clique gauche souris 
        if x >= buttonEasy.x and x <= buttonEasy.x + buttonEasy.width and
           y >= buttonEasy.y and y <= buttonEasy.y + buttonEasy.height then
            difficulties = "easy"
            scene = "game"
            love.load()
        end 
    end 


    if button == 1 then -- clique gauche souris 
        if x >= buttonMedium.x and x <= buttonMedium.x + buttonMedium.width and
           y >= buttonMedium.y and y <= buttonMedium.y + buttonMedium.height then
            difficulties = "medium"
            scene = "game"
            love.load()
        end  
    end

    if button == 1 then -- clique gauche souris 
        if x >= buttonHard.x and x <= buttonHard.x + buttonHard.width and
           y >= buttonHard.y and y <= buttonHard.y + buttonHard.height then
            difficulties = "hard"
            scene = "game"
            love.load()
        end  
    end
end

return menu3
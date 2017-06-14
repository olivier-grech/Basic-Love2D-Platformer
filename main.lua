-- Löve2D functions
function love.load()

	-- Initialize player characteristics
	player_x = 10;
	player_y = 10;
	player_horizontal_speed = 3;
	player_vertical_speed = 3;

	-- Initialize world characteristics
	gravity = -0.7;

end
 
function love.update(dt)

	-- Check whether the player is pressing some keys
	if love.keyboard.isDown("up") then
		up = 1
	else
		up = 0
	end

	if love.keyboard.isDown("down") then
		down = -1
	else
		down = 0
	end

	if love.keyboard.isDown("left") then
		left = -1
	else
		left = 0
	end

	if love.keyboard.isDown("right") then
		right = 1
	else
		right = 0
	end
	
	-- Calculate the horizontal speed
	current_horizontal_speed = (left+right)*player_horizontal_speed;

	--Calculate the vertical speed


	-- Move the player
	player_x = player_x + current_horizontal_speed


end
 
function love.draw()

	--Draw the player
    love.graphics.setColor(233, 30, 99)
    love.graphics.rectangle("fill", player_x, player_y, 20, 20)

    -- Draw the level
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 0, 580, 800, 20)
    
end

-- My functions
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1 < x2+w2 and
    	x2 < x1+w1 and
        y1 < y2+h2 and
        y2 < y1+h1
end
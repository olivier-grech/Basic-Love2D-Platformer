-- Löve2D functions
function love.load()

	-- Initialize player characteristics
	player = {x = 10, y = 10, w = 20, h = 20, horizontal_speed = 150, max_fall_speed = 200}
	current_horizontal_speed = 0
	current_vertical_speed = 0
	
	-- Initialize world characteristics
	gravity = 10

	-- Define platforms coordinates
	ground = {x = 0, y = 580, w = 800, h = 20}
	wall = {x = 360, y = 500, w = 80, h = 80}
	platforms = {ground, wall}

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
	current_horizontal_speed = (left + right) * player.horizontal_speed;

	--Calculate the vertical speed
	if current_vertical_speed + gravity < player.max_fall_speed then
		current_vertical_speed = current_vertical_speed + gravity;
	else
		current_vertical_speed = player.max_fall_speed
	end


	-- Move the player
	player.x = player.x + current_horizontal_speed * dt
	player.y = player.y + current_vertical_speed * dt

	
	--[[
	if (place_meeting(x, y+vsp, obj_wall)) {
		while(!place_meeting(x, y+sign(vsp), obj_wall)) {
        	y += sign(vsp);
    	}
	}
	else {	    
		y += vsp;
	}
	}]]--

end
 
function love.draw()

	--Draw the player
    love.graphics.setColor(233, 30, 99)
    love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)

    -- Draw the level
    love.graphics.setColor(255, 255, 255)
    for i, platform in ipairs(platforms) do
    	love.graphics.rectangle("fill", platform.x, platform.y, platform.w, platform.h)
    end

end

-- My functions
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1 < x2+w2 and
    	x2 < x1+w1 and
        y1 < y2+h2 and
        y2 < y1+h1
end
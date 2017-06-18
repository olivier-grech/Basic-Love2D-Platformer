-- Löve2D functions --

function love.load()

	-- Initialize player characteristics
	player = {x = 10, y = 10, w = 20, h = 20, horizontal_speed = 10, jump_speed = 200}
	hsp = 0
	vsp = 0
	
	-- Initialize world characteristics
	gravity = 10
	fall_speed = 10

	-- Define platforms coordinates
	ground = {x = 0, y = 580, w = 800, h = 20}
	wall = {x = 360, y = 500, w = 80, h = 80}
	platforms = {ground, wall}

end
 
function love.update(dt)

	-- Check whether the player is pressing some keys
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
	hsp = (left + right) * player.horizontal_speed;

	--Calculate the fall speed
	if vsp + gravity < fall_speed then
		vsp = vsp + gravity;
	else
		vsp = fall_speed
	end

	--Calculate the jump speed
	if love.keyboard.isDown("up") then
		vsp = vsp + player.jump_speed
	end

	-- Move the player
	if hsp >= 0 then
		hoffset = player.w
	else
		hoffset = 0
	end

	if vsp >= 0 then
		voffset = player.h
	else
		voffset = 0
	end

	if CheckGroundAtPlace(player.x + hoffset + hsp, player.y) then
		while not CheckGroundAtPlace(player.x + hoffset + Sign(hsp), player.y) do
			player.x = player.x + Sign(hsp) 
		end
	else
		player.x = player.x + hsp 
	end

	if CheckGroundAtPlace(player.x, player.y + voffset + vsp) then
		while not CheckGroundAtPlace(player.x, player.y + voffset + Sign(vsp)) do
			player.y = player.y + Sign(vsp) 
		end
	else
		player.y = player.y + vsp 
	end

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

-- My functions --

-- Check for overlap between to boxes
function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
	return x1 < x2 + w2 and
    	x2 < x1 + w1 and
        y1 < y2 + h2 and
        y2 < y1 + h1
end

-- Check for presence of ground at given coordinates
function CheckGroundAtPlace(x, y)
	ret = false
	for i, platform in ipairs(platforms) do
    	if CheckCollision(platform.x, platform.y, platform.w, platform.h, x, y, 1, 1) then
			ret = true
		end
    end
	return ret 
end

-- Return the sign of a given number
function Sign(number)
	if number >= 0 then
		return 1
	else 
		return -1
	end
end
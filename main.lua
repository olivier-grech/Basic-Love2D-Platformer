-- Löve2D functions --

function love.load()

 	-- Initialize player characteristics
	player = {x = 100, y = 560, w = 20, h = 20, speed = 5, jumpspeed = 20}
	hsp = 0
	vsp = 0
	
	-- Initialize world characteristics
	gravity = 1
	fallspeed = 7

	-- Define platforms coordinates
	ground = {x = 0, y = 580, w = 800, h = 20}
	ceiling = {x = 0, y = 0, w = 800, h = 20}
	wallleft = {x = 0, y = 0, w = 20, h = 600}
	wallright = {x = 780, y = 0, w = 20, h = 600}
	platformcenter = {x = 360, y = 500, w = 80, h = 80}
	platform1 = {x = 250, y = 500, w = 50, h = 30}
	platform2 = {x = 500, y = 500, w = 50, h = 30}
	platforms = {ground, ceiling, wallleft, wallright, platformcenter, platform1, platform2}

end
 
function love.update(dt)

	-- Check whether the player is pressing some keys and calculate the horizontal speed
	if love.keyboard.isDown("left") then
		hsp = -player.speed
	elseif love.keyboard.isDown("right") then
		hsp = player.speed
	else 
		hsp = 0
	end

	--Calculate the fall speed
	if vsp + gravity < fallspeed then
		vsp = vsp + gravity
	else
		vsp = fallspeed
	end

	--Calculate the jump speed
	if love.keyboard.isDown("up") and CheckGroundAtPlace(player.x, player.y + player.h, 1, 1) then
		vsp = vsp - player.jumpspeed
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

	if CheckGroundAtPlace(player.x + hoffset + hsp, player.y, 1, player.h) then
		while not CheckGroundAtPlace(player.x + hoffset + Sign(hsp) - 1, player.y, 1, player.h) do
			player.x = player.x + Sign(hsp) 
		end
	else
		player.x = player.x + hsp 
	end

	if CheckGroundAtPlace(player.x, player.y + voffset + vsp, player.w, 1) then
		while not CheckGroundAtPlace(player.x, player.y + voffset + Sign(vsp) - 1, player.w, 1) do
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
function CheckGroundAtPlace(x, y, w, h)
	ret = false
	for i, platform in ipairs(platforms) do
    	if CheckCollision(platform.x, platform.y, platform.w, platform.h, x, y, w, h) then
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

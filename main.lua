function love.load ()
	enemyX, enemyY = 300, 600
	evX, evY = 0, -1
	playerX, playerY = 100, 100
	velX, velY = 0, 1 
	VEL = 100
	ANG = 1.5
	DOT = 0
	dots = {}
	dots.x = {}
	dots.y = {}
	bulletTime = 0
	table.insert( dots.x, playerX )
	table.insert( dots.y, playerY )
	-- (vx, vy) é o vetor da direção da nave, normalizado (|(vx,vy)| = 1)
	
	love.graphics.setBackgroundColor( 0, 0, 0 )
	
end

function love.update (dt)
	bulletTime = bulletTime - dt

	if ( love.keyboard.isDown("w") ) then
		playerX = playerX + velX * VEL * dt
		playerY = playerY + velY * VEL * dt
	end
	if ( love.keyboard.isDown("a") and not love.keyboard.isDown("d") ) then
		local alpha = ANG * dt
		local vx = velX * math.cos(alpha) - velY * math.sin(alpha)
		local vy = velX * math.sin(alpha) + velY * math.cos(alpha)
		DOT = DOT + dt * ANG*20
		velX = vx
		velY = vy
		-- rotaciona (vx, vy) no sentido anti-horario
	elseif ( love.keyboard.isDown("d") ) then
		local alpha = ANG * dt
		local vx = velX * math.cos(-alpha) - velY * math.sin(-alpha)
		local vy = velX * math.sin(-alpha) + velY * math.cos(-alpha)
		DOT = DOT + dt * ANG*20
		velX = vx
		velY = vy
		-- rotaciona (vx, vy) no sentido horario
	end
	if( ( love.keyboard.isDown("e") or love.keyboard.isDown("q") ) and bulletTime < -1 ) then
		bulletTime = 0.2
		bulletA = playerX
		bulletB = playerY
		bulletC = playerX + velX * 200
		bulletD = playerY + velY * 200
		--atira
	end
	
	if ( DOT > 1 ) then
		DOT = 0
		table.insert( dots.x, playerX )
		table.insert( dots.y, playerY )
	end
	
	
end

function love.draw ()
	love.graphics.setLineWidth( 14 )
	love.graphics.setColor( 10, 10, 10 )
	for i = 1, #dots.x do
		if ( i > 1 ) then
			love.graphics.line( dots.x[i-1], dots.y[i-1], dots.x[i], dots.y[i] )
		end
		love.graphics.circle( "fill", dots.x[i], dots.y[i], 7, 100 )
	end
	love.graphics.line( dots.x[#dots.x], dots.y[#dots.x], playerX, playerY )
	
	
	love.graphics.setColor( 255, 255, 255 )
	love.graphics.circle( "fill", playerX, playerY, 5, 10 )
	
	
	if ( bulletTime > 0 ) then
		love.graphics.setColor( 200, 0, 0 )
		love.graphics.line( bulletA, bulletB, bulletC, bulletD )
	end
end

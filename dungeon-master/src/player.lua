-- player
player = {
	-- pos
	x=51.5,
	y=7.5,
	dx=56.5,
	dy=7.5,
	rot=0,
	rot2=0,
	dir="➡️",
	can_rotate=true,
	can_move=true,
	}

function player:controller()
	if game_tick%10 == 0 then
		player:turn()
	end
end

function player:rotate()
	if player.rot!=player.rot2 then
			player.can_rotate=false
			-- rotate right
			if player.rot<player.rot2 then
				player.rot+=0.02
				
				-- prevent from rotation snaping
				if player.rot>player.rot2 then
					player.rot=player.rot2
				end
			-- rotatr left
			else
				player.rot-=0.02
				if player.rot<player.rot2 then
					player.rot=player.rot2
				end
			end
			
			-- prevent from negative number
			if player.rot2<0 then
				player.rot2+=1
				player.rot+=1
			end
			
			-- prevents from rotating over 1
			if player.rot2>1 then
				player.rot2-=1
				player.rot-=1
			end
		else
			player.can_rotate=true
		end
end

function player:move()
	if player.x!=player.dx then
		player.can_move=false
		-- move forward
		if player.x<player.dx then
			player.x+=0.05
				
			-- prevent from movement snapping
			if player.x>player.dx then
				player.x=player.dx
			end
			
			-- move backword
		else
			player.x-=0.05
			-- prevent from movement snapping
			if player.x<player.dx then
				player.x=player.dx
			end
		end
	end
		
	if player.y!=player.dy then
		player.can_move=false
		-- move forward
		if player.y<player.dy then
			player.y+=0.05
				
			-- prevent from movement snapping
			if player.y>player.dy then
				player.y=player.dy
			end
			-- move backword
		else
			player.y-=0.05
			if player.y<player.dy then
				player.y=player.dy
			end
		end
	end
	if player.x==player.dx and
				player.y==player.dy then
				player.can_move=true
	end
end

-- check player direction
function player:check_direction()
	if player.rot2 == 0.25 then
		player.dir = "⬆️"
	elseif player.rot2 == 0.50 then
		player.dir = "⬅️"
	elseif player.rot2 == 0.75 then
		player.dir = "⬇️"
	elseif player.rot2 == 1 or 0 then
		player.dir = "➡️"
	end
end

function player:turn()
	if player.can_move and player.can_rotate then
		local x,y=cos(player.rot),sin(player.rot)
		if collision:check(player.dx + x, player.dy + y, x, y, 0) then
			player.rot2 += 0.25
			return
		elseif collision:check(player.dx + x, player.dy + y, x, y, 2) then
			player.x = 1.5
			player.y = 5.5
			player.dx = 1.5
			player.dy = 5.5
			player.rot=0
			player.rot2=0
			stage.st = "map_ed"
			return
		elseif collision:check(player.dx + x, player.dy + y, x, y, 1) then
			player:next_level()
			for x = 0, 130, 3 do
				level_ed:draw()
				rectfill(x, 0, 128, 128, 0)
				print("\^1", 0, 0)
			end
		elseif collision:check(player.dx + x, player.dy + y, x, y, 4) then
			player:portal(5)
			ui:rrender()
		elseif collision:check(player.dx + x, player.dy + y, x, y, 5) then
			player:portal(4)
			ui:rrender()
		elseif collision:check(player.dx + x, player.dy + y, x, y, 6) then
			player:portal(7)
			ui:rrender()
		elseif collision:check(player.dx + x, player.dy + y, x, y, 7) then
			player:portal(6)
			ui:rrender()
		elseif collision:check(player.dx + x, player.dy + y, x, y, 3) then
			sfx(3)
			cls(1)
			print("\^5", 0, 0)
			cls(5)
			print("\^5", 0, 0)
			cls(6)
			print("\^5", 0, 0)
			cls(7)
			print("\^5", 0, 0)
			stage.st = "end"
		else
			player.dx+=x
			player.dy+=y
			sfx(1)
			print("\^1")
		end
	end
end

function player:back_to_ed()
	player.x = 1.5
	player.y = 5.5
	player.dx = 1.5
	player.dy = 5.5
	player.rot=0
	player.rot2=0
	stage.st = "map_ed"
	return
end

function player:next_level()
	sfx(3)
	player.x = 1.5
	player.y = 5.5
	player.dx = 1.5
	player.dy = 5.5
	player.rot=0
	player.rot2=0
	game_data.level += 1
	game_data.blocks = 10
	level_ed.ny += 12
	if level_ed.ny > 52 then
		level_ed.nx += 16
		level_ed.ny = 3
	end
	level_ed.new()
	stage.st = "map_ed"
	return
end

function player:portal(f)
	sfx(2)
	for x = 0, 127 do
		for y = 0, 12 do
			if fget(mget(x, y + 3), f) then
				player.x = x + 0.5
				player.y = y + 3.5
				player.dx = x + 0.5
				player.dy = y + 3.5
				return
			end
		end
	end
end

	-- for menuitem
function next_level()
	player:next_level()
end

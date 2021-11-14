-- init
function _init()
	
	-- set sec palette
	for i=0,15 do
		pal(i,i+128,2)
	end

		-- init cursor
	poke(0x5f2d, 1) -- init coursor
	
		-- create scanlines
	poke(24415,16)
	memset(24432,170,16)

		-- repeat buttin press delay
    poke(0x5f5c,255)
    poke(0x5f5d,255)

	game_tick = 0

	game_data = {
		level = 1,
		blocks = 10,
	}

	-- menuitem(1, "debug: next level", next_level)
end

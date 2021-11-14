level_ed = {
  map_name = "test",
  av_blocks = 99,
  nx = 0,
  ny = 3,
}

function level_ed:draw()
  cls()
  map(0, 3, 0, 0, 16, 12)
  ui:bbox(0, 96, 127, 127)
  print("level: "..game_data.level, 8, 104, 7)
  print("blocks: "..game_data.blocks, 8, 114, 7)
end

function level_ed:update()
end

function level_ed:new()
  for x = 0, 16 do
    for y = 0, 12 do
      mset(x, y + 3, mget(x + level_ed.nx, y + level_ed.ny))
    end
  end
end

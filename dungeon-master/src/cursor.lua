curs = {
  spr = {48, 49},
  cspr = 1,
  x = stat(32) - 4,
  y = stat(33) - 4,
  bt = stat(34),
}

function curs:update()
  curs.x = stat(32)
  curs.y = stat(33)
  curs.bt = stat(34)

  if game_tick%24 == 0 then
    curs.cspr = 1
  elseif game_tick%12 == 0 then
    curs.cspr = 2
  end

  if curs.bt == 1 then curs:place() end
  if curs.bt == 2 then curs:remove() end
end

function curs:draw()
  -- calculating position again to avoid visual glitch
  spr(curs.spr[curs.cspr], stat(32) - 4, stat(33) - 4)
end

function curs:place()
  if mget(curs.x\8, curs.y\8 + 3) == 0
    and game_data.blocks > 0
    and curs.y < 12 * 8
    and curs.y > 1 * 8
    and curs.x < 128
    and curs.x > 0 then
    -- if curs.el[curs.csel] <= 0 then return end
    -- curs.el[curs.csel] -= 1
    mset(curs.x\8, curs.y\8 + 3, 6)
    game_data.blocks -= 1
  end
end

function curs:remove()
  if mget(curs.x\8, curs.y\8 + 3) == 6 then
    -- if curs.el[curs.csel] <= 0 then return end
    -- curs.el[curs.csel] -= 1
    mset(curs.x\8, curs.y\8 + 3, 0)
    game_data.blocks += 1
  end
end

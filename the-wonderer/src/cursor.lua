curs = {
  x = stat(32) - 4 + player.x - 64,
  y = stat(33) - 4 + player.y - 64,
  bt = stat(34),

  csel = 1,
  sel = {20, 21, 51},
  el = {
    28,
    5,
    36,
  },
}

function curs:update()
  curs.x = stat(32) + player.x - 64
  curs.y = stat(33) + player.y - 64
  curs.bt = stat(34)

  if btnp(1) then
    curs.csel += 1
    if curs.csel > #curs.sel then curs.csel = 1 end

  elseif btnp(0) then
    curs.csel -= 1
    if curs.csel <= 0 then curs.csel = #curs.sel end
  end

  if curs.bt == 1 then curs:coll() end
end

function curs:draw()
  -- calculating position again to avoid visual glitch
  spr(54, stat(32) - 4 + player.x - 64, stat(33) - 4 + player.y - 64)
end

function curs:coll()
  if fget(mget(curs.x\8, curs.y\8), 7) and player:coll(player, "center", 7) == false then
    if curs.el[curs.csel] <= 0 then return end
    curs.el[curs.csel] -= 1
    mset(curs.x\8 , curs.y\8, curs.sel[curs.csel])
  end
end

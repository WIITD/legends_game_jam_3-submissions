state = {
  st = "intro",
  help_ico = {{54, 19}, {56, 55}},
  help_ico_type = 1,
}

function state:update()
  if state.st == "intro" then
    state:intro_update()

  elseif state.st == "menu" then
    state:menu_update()

  elseif state.st == "help" then
    state:help_update()

  elseif state.st == "game" then
    state:game_update()

  elseif state.st == "end" then
    state:end_update()
  end
end

function state:draw()
  if state.st == "intro" then
    state:intro_draw()

  elseif state.st == "menu" then
    state:menu_draw()

  elseif state.st == "help" then
    state:help_draw()

  elseif state.st == "game" then
    state:game_draw()

  elseif state.st == "end" then
    state:end_draw()
  end
end

  -- INTRO

function state:intro_draw()
  cls(12)
  camera(player.x - 64, player.y - 64)
  for i = -68, 0 do
    cls(12)
    state:draw_sky()
    map(0, 0, 0, 0, 128, 128)
    spr(11, player.x, player.y, 1, 1, false)
    ui:bbox(-68, -2-58, i, 32-58)
    print("the wonderer\n\n\f6by wiitd", i - 56, 4-56, 7)

    ui:bbox(-68, -16, i, 0)
    print("[x] : start", i - 60, -10, 7)

    ui:bbox(-68, 8, i, 24)
    print("[z] : tutorial", i-60, 14, 7)

    print("\^1", 0, 0)
  end
  state.st = "menu"
end

function state:intro_update()
end

  -- MENU

function state:menu_draw()
  cls(12)
  map(0, 0, 0, 0, 128, 128)
  state:draw_sky()
  spr(11, player.x, player.y, 1, 1, false)

  ui:bbox(-68, -60, 0, -26)
  print("the wonderer\n\n\f6by wiitd", -56, 4-56, 7)

  ui:bbox(-68, -16, 0, 0)
  print("[x] : start", -60, -10, 7)

  ui:bbox(-68, 8, 0, 24)
  print("[z] : tutorial", -60, 14, 7)

  if btnp(5) then
    for i = 0, -80, -1 do
      cls(12)
      state:draw_sky()
      map(0, 0, 0, 0, 128, 128)
      spr(11, player.x, player.y, 1, 1, false)

      ui:bbox(-68, -2-58, i, 32-58)
      print("the wonderer\n\n\f6by wiitd", i-56, -52, 7)

      ui:bbox(-68, -16, i, 0)
      print("[x] : start", i-60, -10, 7)

      ui:bbox(-68, 8, i, 24)
      print("[z] : tutorial", i-60, 14, 7)

      print("\^1", 0, 0)
    end
    state.st = "game"
  end
  if btnp(4) then
    for x = -64, 64, 2 do
      ui:bbox(-64, -56, x-1, x+8)
      print("\^1", 0, 0)
    end
    state.st = "help"
  end
end

function state:menu_update()
end

  -- HELP

function state:help_draw()
  ui:bbox(-64, -56, 63, 72)
  print("use    to place block on\n\n\nuse ⬅️ ➡️ to change block type\n\n\n\n[x] back to menu", -60, -52, 7)
  spr(state.help_ico[state.help_ico_type][1], -44, -54)
  spr(state.help_ico[state.help_ico_type][2], 40, -54)
  if game_tick%32 == 0 then
    state.help_ico_type = 1
  elseif game_tick%16 == 0 then
    state.help_ico_type = 2
  end
end

function state:help_update()
  if btnp(5) then
    state.st = "intro"
  end
end

  -- GAME

function state:game_draw()
  if player.y > 128 then
    cls(13)
  else
    cls(12)
  end

  camera(player.x - 64, player.y - 64)
  state:draw_sky()
  spr(73, player.x - 64, -32, 2, 2)
  map(0, 0, 0, 0, 128, 128)
  ui:bbox(player.x - 63, player.y + 47, player.x - 31, player.y + 62)
  print(": "..curs.el[curs.csel], player.x - 50, player.y + 53, 7)
  spr(curs.sel[curs.csel], player.x - 59, player.y + 51)
  player:draw(player)
  curs:draw()
end

function state:game_update()
  curs:update()

  if game_tick%2 == 0 then
    player:controller(player)
  end
end

  -- END

function state:end_draw()
  cls()
  ui:bbox(1, 1, 126, 44)
  print("you managed \nto guide him safely \nto his house\n\n thanks for playing", 8, 8, 7)
end

function state:end_update()
end

function state:draw_sky()
  spr(76, player.x - 52, -48, 4, 4)
  spr(71, player.x, -32, -32, 2, 2)
  spr(73, player.x - 48, -32, 2, 2)
  spr(71, player.x, -32, 2, 2)
  spr(73, player.x + 24, -32, 2, 2)
  spr(71, player.x + 32, -32, 2, 2)
  spr(73, player.x - 64, -32, 2, 2)
  map(0, 0, 0, 0, 128, 128)
end

stage = {
  st = "intro"
}

function stage:draw()
  if stage.st == "intro" then stage:intro_draw()
  elseif stage.st == "menu" then stage:menu_draw()
  elseif stage.st == "game" then stage:game_draw()
  elseif stage.st == "map_ed" then stage:map_ed_draw()
  elseif stage.st == "end" then stage:end_draw()
  end
end

function stage:update()
  if stage.st == "intro" then stage:intro_update()
  elseif stage.st == "menu" then stage:menu_update()
  elseif stage.st == "game" then stage:game_update()
  elseif stage.st == "map_ed" then stage:map_ed_update()
  elseif stage.st == "end" then stage:end_update()
  end
end




  -- INTRO

function stage:intro_draw()
  cls(5)
  raycast:render(false)
end

function stage:intro_update()
  player:rotate()
  player:move()
  if player.x == 56.5 then
    player.rot2 += 0.25
    stage.st = "menu"
  end
end


  -- MENU

function stage:menu_draw()
  cls(5)
  raycast:render(false)
  if player.x == 56.5 and player.y == 7.5 then
    ui:bbox(0, -2, 127, 24)
    print("\^t\^wdungeon master", 10, 8, 7)

    ui:bbox(38, 92, 92, 104)
    print("[x] to start", 42, 96, 7)
  end
  if player.y == 5.5 then
    ui:bbox(0, 0, 127, 127)
    print("controls:\n\n - [x] switch between\n\t editor and ai simulation\n\n - [mouse] place and remove\n\t block on them map\n\n - [tip] ai only turns left", 4, 4, 7)
    print("[x] to continue", 34, 118, 6)
  end
end

function stage:menu_update()
  player:rotate()
  player:move()
  if btnp(5) and player.x == 56.5 then
    sfx(0)
    player.dy = 5.5
  end
  if player.y == 5.5 then
    if btnp(5) then
      for x = 0, 130, 3 do
        rectfill(0, 0, x, 128, 0)
        print("\^1", 0, 0)
      end
      player.x=1.5
      player.y=5.5
      player.dx=1.5
      player.dy=5.5
      player.rot=0
      player.rot2=0
      for x = 0, 130, 3 do
        level_ed:draw()
        rectfill(x, 0, 128, 128, 0)
        print("\^1", 0, 0)
      end
      stage.st = "map_ed"
    end
  end
end


  -- GAME

function stage:game_draw()
  cls(1)
  raycast:render(false)
end

function stage:game_update()
  player:controller()
  player:rotate()
  player:move()
  if btnp(5) then
    sfx(0)
    for x = 0, 130, 3 do
      rectfill(0, 0, x, 128, 0)
      print("\^1", 0, 0)
    end
    for x = 0, 130, 3 do
      level_ed:draw()
      rectfill(x, 0, 128, 128, 0)
      print("\^1", 0, 0)
    end
    player:back_to_ed()
  end
end


  -- MAP EDITOR

function stage:map_ed_draw()
  level_ed:draw()
  curs:draw()
end

function stage:map_ed_update()
  level_ed:update()
  curs:update()
  if btnp(5) then
    sfx(0)
    ui:rrender()
    stage.st = "game"
  end
end

  -- END

function stage:end_draw()
  for x=0, 128, 8 do
    for y=0, 128, 8 do
      spr(50, x, y)
    end
  end
  ui:bbox(4, 80, 90, 117)
  print("you managed to guide\nexplorer to the exit\n\n\nthanks for playing", 8, 84, 7)
end

function stage:end_update()
end

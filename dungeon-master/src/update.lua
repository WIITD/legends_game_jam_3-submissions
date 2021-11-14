-- update
function _update60()
  if game_tick >= 9999 then game_tick = 0 end
  game_tick += 1
  stage:update()
end

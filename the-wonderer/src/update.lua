function _update60()
  game_tick += 1
  if game_tick > 9999 then game_tick = 0 end

  state.update()
end

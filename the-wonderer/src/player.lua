player = {
  spr = 1,
  walk_anim = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12},
  x = 0,
  y = 8,
  dx = 1,
}

function player:controller(self)

  -- animation
  if game_tick%5 == 0 then
    self.spr += 1
    if self.spr > #self.walk_anim - 3 then self.spr = 1 end
  end

    -- if stuck
  if player:coll(self, "center", 0) then
    self.y -= 5
  end

    -- if on spikes
  if player:coll(self, "center", 6) then
    self.spr = 11

    -- ladder
  elseif player:coll(self, "center", 1) then
    self.spr = 9
    self.y -= 0.2
    if game_tick%32 == 0 then
      sfx(1)
    end
    if player:coll(self, "down", 1) and player:coll(self, "center", 1) == false then
      self.spr = 10
      self.y = flr(self.y - 5)
    end
    if player:coll(self, "up", 0) then
      if player:coll(self, "center", 1) or player:coll(self, "left", 1) or player:coll(self, "right", 1) then
        self.y += 2
        self.x += 4 * self.dx * -1
        player:move(self)
      end
    end

      -- ending
  elseif player:coll(self, "right", 3) or player:coll(self, "center", 3) then
    camera(0, 0)
    state.st = "end"

      -- falling
  elseif player:coll(self, "down", 0) == false and player:coll(self, "down", 1) == false then
    self.y += 2
    self.spr = 1

    -- turn left or riht
  elseif self.dx < 0 and player:coll(self, "left", 0) or self.dx > 0 and player:coll(self, "right", 0) then
    player:move(self)

    -- destroy certain blocks of beneath ai
  elseif player:coll(self, "down", 0) and player:coll(self, "down", 2) then
    mset(self.x\8 + self.dx, self.y\8 + 1, 19)

    -- walk cycle
  else
    self.x += self.dx
    if game_tick%26 == 0 then
      sfx(0)
    end
  end
end

function player:move(self)
  if self.dx > 0 then
    self.dx = -1
    self.x += self.dx
  else
    self.dx = 1
  end
end

function player:coll(self, dir, flg)
  local en = {
    x = self.x,
    y = self.y,
    w = 8,
    h = 8,
  }

  xpos = {0, 0}
  ypos = {0, 0}

  if dir == "left" then
    xpos[1] = en.x - 0.5
    ypos[1] = en.y
    xpos[2] = en.x
    ypos[2] = en.y + en.h - 0.5

  elseif dir == "right" then
    xpos[1] = en.x + en.w
    ypos[1] = en.y
    xpos[2] = en.x + en.w + 0.5
    ypos[2] = en.y + en.h - 0.5

  elseif dir == "up" then
    xpos[1] = en.x + 0.5
    ypos[1] = en.y - 0.5
    xpos[2] = en.x + en.w/2 - 0.5
    ypos[2] = en.y

  elseif dir == "down" then
    xpos[1] = en.x
    ypos[1] = en.y + en.h
    xpos[2] = en.x + en.w/2
    ypos[2] = en.y + en.h/2

  elseif dir == "center" then
    xpos[1] = en.x + 4
    ypos[1] = en.y + 4
    xpos[2] = en.x + 4/2
    ypos[2] = en.y + 4/2
  end

  xpos[1] \= 8
  xpos[2] \= 8
  ypos[1] \= 8
  ypos[2] \= 8
  if fget(mget(xpos[1],ypos[1]), flg)
    or fget(mget(xpos[1],ypos[2]), flg)
    or fget(mget(xpos[2],ypos[1]), flg)
    or fget(mget(xpos[2],ypos[2]), flg) then
    return true
  else
    return false
  end
end


function player:draw()
  if player.dx > 0 then
    spr(self.walk_anim[self.spr], self.x, self.y, 1, 1, false)
  else
    spr(self.walk_anim[self.spr], self.x, self.y, 1, 1, true)
  end
end

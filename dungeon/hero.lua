function hero_new(pos)
  local h = {
    flip = false
  }
  mov_init(h, VEC.cp(pos))
  return h
end

function hero_update()
  mov_update(hero)
end

function draw_crosshair()
  local len = 8
  circ(hero.pos.x + 4 + hero.dir.x * len, hero.pos.y + 4 + hero.dir.y * len, 1, 8)
end
function hero_draw()
  if hero.dir and hero.dir.x ~=0 then
    hero.flip = hero.dir.x == -1
  end
  spr(147, hero.pos.x, hero.pos.y, 1, 1, hero.flip)
  if hero.dir then
    draw_crosshair()
  end
end

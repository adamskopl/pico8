function hero_new(pos)
  local h = {
    flip = false
  }
  MOV.init(h, VEC.cp(pos))
  ANIM.create_loop(h, 147, 144, 147, 0.05)
  return h
end

function hero_update()
  MOV.update(hero)
  ANIM.update(hero)
end

function draw_crosshair()
  local len = 8
  circ(hero.pos.x + 4 + hero.dir.x * len, hero.pos.y + 4 + hero.dir.y * len, 1, 8)
end
function hero_draw()
  if hero.dir and hero.dir.x ~= 0 then
    hero.flip = hero.dir.x == -1
  end
  spr(147, hero.pos.x, hero.pos.y, 1, 1, hero.flip)
  if hero.dir then
    draw_crosshair()
  end
end

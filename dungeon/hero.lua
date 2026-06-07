function hero_new(pos)
  local h = {
    flip = false
  }
  MOV.init(h, VEC.cp(pos))
  ANIM.create_loop(h, 164, 164, 167, 0.04)
  return h
end

function hero_update()
  MOV.update(G.hero)
  ANIM.update(G.hero)
end

function draw_crosshair()
  local len = 8
  circ(G.hero.pos.x + 4 + G.hero.dir.x * len, G.hero.pos.y + 4 + G.hero.dir.y * len, 1, 8)
end
function hero_draw()
  ANIM.draw(G.hero)
  if G.hero.dir then
    draw_crosshair()
  end
end

HERO = {}

function HERO.create(pos)
  local p = {}
  MOV.init(p, VEC.cp(pos))
  ANIM.create_loop(p, 147, 144, 147, 0.05)
  return p
end

function HERO.update()
  ANIM.update(G.hero)
  MOV.update(G.hero)
end

local function draw_crosshair()
  local p = G.hero
  local len = 8
  circ(p.vec.x + 4 + p.dir.x * len, p.vec.y + 4 + p.dir.y * len, 1, 8)
end
function HERO.draw()
  ANIM.draw(G.hero)
  -- draw_crosshair()
end

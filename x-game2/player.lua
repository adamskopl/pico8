PLAYER = {}

function PLAYER.create(pos)
  local p = {}
  MOV.init(p, VEC.cp(pos))
  ANIM.create_loop(p, 147, 144, 147, 0.05)
  return p
end

function PLAYER.update()
  ANIM.update(G.player)
  MOV.update(G.player)
end

local function draw_crosshair()
  local p = G.player
  local len = 8
  circ(p.vec.x + 4 + p.dir.x * len, p.vec.y + 4 + p.dir.y * len, 1, 8)
end
function PLAYER.draw()
  ANIM.draw(G.player)
  -- draw_crosshair()
end

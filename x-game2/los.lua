-- ===== line of sight =====--
LOS = {}

function visible(v_src, v_dst)
  local dx = v_dst.x - v_src.x
  local dy = v_dst.y - v_src.y

  local steps = max(abs(dx), abs(dy))
  -- TODO experiment with steps number
  steps = flr(steps / 2)
  printh('steps ' .. steps)

  local x = v_src.x + 4
  local y = v_src.y + 4

  local stepx = dx / steps
  local stepy = dy / steps

  for i = 1, steps do
    x = x + stepx
    y = y + stepy

    -- round to 8 to target tile
    local ix = flr(x / 8) * 8
    local iy = flr(y / 8) * 8
    add(LOS.v_steps, VEC.from(x, y))
    add(LOS.v_steps_tiles, VEC.from(ix, iy))

    if ix == v_dst.x and iy == v_dst.y then
      return true
    end

    if LVL.is_wall(VEC.from(ix, iy)) then
      return false
    end
  end
  return true
end

function LOS.init()
  printh('init')
  local test_vec = VEC.from(4, 1)
  local test_vec2 = VEC.from(-4, 1)
  LOS.v_target = VEC.add(G.hero.vec, VEC.multi(test_vec, 8))
  LOS.v_target2 = VEC.add(G.hero.vec, VEC.multi(test_vec2, 8))
end

function LOS.update()
  LOS.v_steps = {}
  LOS.v_steps_tiles = {}
  visible(G.hero.vec, LOS.v_target)
  visible(G.hero.vec, LOS.v_target2)
end

function LOS.draw()
  DRAW.rect(LOS.v_target, COLORS.GREEN)
  DRAW.rect(LOS.v_target2, COLORS.ORANGE)
  for s in all(LOS.v_steps_tiles) do
    DRAW.rect(s, COLORS.RED)
  end
  for s in all(LOS.v_steps) do
    pset(s.x, s.y, COLORS.WHITE)
  end
end

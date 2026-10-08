HERO = {}
function HERO.new(pos)
  local h = ENTITY.new(pos)
  MOV.apply(h)
  ANIM.apply_loop(h, 164, 164, 167, 0.04)
  h.teleport_target = ENTITY.new(VEC.new(0, 0))
  ANIM.apply_loop(h.teleport_target, GFX.SPARK, GFX.SPARK, GFX.SPARK + 3, 0.1)
  ANIM.start(h.teleport_target)
  return h
end

function HERO.update()
  MOV.update(G.hero)
  ANIM.update(G.hero)
  teleport_update()

  -- COINS COLLISION
  for i = #G.coins, 1, -1 do
    if TILES.collide(G.hero.pos, G.coins[i].pos) then
      deli(G.coins, i)
      sfx(SFX.COIN)
    end
  end
end
function teleport_update()
  ANIM.update(G.hero.teleport_target)

  if not G.hero.dir then
    return
  end

  DEBUGGER.clear()
  local h = G.hero
  local pos_m_now = pos_to_pos_m(h.pos, h.dir)
  local pos_m_next = VEC.add(pos_m_now, h.dir)
  local pos_m_last = pos_m_next
  while not wall_in_pos_m(pos_m_next) do
    pos_m_last = pos_m_next
    pos_m_next = VEC.add(pos_m_next, h.dir)
  end
  if not VEC.eq(pos_m_last, pos_m_now) then
    h.teleport_target.pos = VEC.multi(pos_m_last, 8)
  end
end

-- TODO will be replaced with showing teleport mark
function draw_crosshair()
  local len = 8
  circ(G.hero.pos.x + 4 + G.hero.dir.x * len, G.hero.pos.y + 4 + G.hero.dir.y * len, 1, 8)
end
function HERO.draw()
  ANIM.draw(G.hero)
  ANIM.draw(G.hero.teleport_target, true)
end

COINS = {}
function COINS.new(pos)
  local c = ENTITY.new(pos)
  ANIM.apply_loop(c, GFX.COIN, GFX.COIN, GFX.COIN + 3, 0.1)
  ANIM.start(c)
  return c
end
function COINS.load(level)
  G.coins = {}
  for c_pos in all(level.coins) do
    local c = COINS.new(VEC.multi(c_pos, 8))
    add(G.coins, c)
  end
end
function COINS.update()
  for c in all(G.coins) do
    ANIM.update(c)
  end
end
function COINS.draw()
  for c in all(G.coins) do
    ANIM.draw(c)
  end
end

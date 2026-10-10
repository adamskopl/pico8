HERO = {}
function HERO.new(pos)
  local h = ENTITY.new(pos)
  MOV.apply(h)
  ANIM.apply_loop(h, 164, 164, 167, 0.04)
  h.teleport_target = ENTITY.new(VEC.new(0, 0))
  h.teleport_target.active = false
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
  local h = G.hero
  if not h.dir then
    return
  end
  ANIM.update(h.teleport_target)

  local pos_m_now = pos_to_pos_m(h.pos, h.dir)
  local pos_m_next = VEC.add(pos_m_now, h.dir)
  local pos_m_last_open = nil
  while not wall_in_pos_m(pos_m_next) do
    pos_m_last_open = pos_m_next
    pos_m_next = VEC.add(pos_m_next, h.dir)
  end
  if pos_m_last_open then
    h.teleport_target.pos = VEC.multi(pos_m_last_open, 8)
    h.teleport_target.active = true
  else
    h.teleport_target.active = false
  end
end

function HERO.draw()
  ANIM.draw(G.hero)
  if G.hero.teleport_target.active then
    ANIM.draw(G.hero.teleport_target)
  end
end

function HERO.on_O_press()
  if G.hero.teleport_target.active then
    G.hero.pos = G.hero.teleport_target.pos
    G.hero.teleport_target.active = false
    MOV.stop(G.hero)
  end
end

function HERO.on_X_press() end

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

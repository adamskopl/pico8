HERO = {}
ORBIT_RADIUS_HERO = 7
ORBIT_SPEED_HERO = 0.015

function HERO.new(pos)
  local h = ENTITY.new(pos)
  MOV.apply(h, 1, true)
  ANIM.apply_loop(h, 164, 164, 167, 0.04)
  h.teleport_target = ENTITY.new(VEC.new(0, 0))
  h.teleport_target.active = false
  h.mana = 5
  ANIM.apply_loop(h.teleport_target, GFX.SPARK, GFX.SPARK, GFX.SPARK + 3, 0.1)
  ANIM.start(h.teleport_target)
  ORBITS.apply(h, h.mana, ORBIT_RADIUS_HERO, ORBIT_SPEED_HERO)
  return h
end

function HERO.update()
  MOV.update(hero)
  ANIM.update(hero)
  ORBITS.update(hero)
  teleport_update()
  mana_collect()

  -- COINS COLLISION
  for i = #coins, 1, -1 do
    if TILES.collide(hero.pos, coins[i].pos) then
      deli(coins, i)
      sfx(SFX.COIN)
    end
  end
end
function teleport_update()
  local h = hero
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
function mana_collect()
  for key, m in pairs(mana_orbits) do
    if TILES.collide(hero.pos, m.pos) then
      hero.mana = hero.mana + ORBITS.count(m)
      mana_orbits[key] = nil
      ORBITS.apply(hero, hero.mana, ORBIT_RADIUS_HERO, ORBIT_SPEED_HERO)
      sfx(SFX.COLLECT)
    end
  end
end

function HERO.draw()
  ANIM.draw(hero)
  ORBITS.draw(hero)
  if hero.teleport_target.active then
    ANIM.draw(hero.teleport_target)
  end
end

function HERO.on_O_press() -- FIRE
  local h = hero
  if h.mana <= 0 then
    sfx(SFX.EMPTY)
    return
  end
  if not h.dir then
    return
  end
  FIREBALLS.fire()
  mana_decrease()
end

function HERO.on_X_press() -- TELEPORT
  if hero.mana <= 0 then
    sfx(SFX.EMPTY)
    return
  end
  if hero.teleport_target.active then
    ANIM.create_single(hero.pos, GFX.EXPLOSION, GFX.EXPLOSION + 3, 0.05)
    MANA.add(hero.pos)
    hero.pos = hero.teleport_target.pos
    ANIM.create_single(hero.pos, GFX.DUST, GFX.DUST + 7, 0.04)
    hero.teleport_target.active = false
    MOV.stop(hero)
    sfx(SFX.TELEPORT)
    mana_decrease()
  end
end

function mana_decrease()
  hero.mana = hero.mana - 1
  ORBITS.apply(hero, hero.mana, ORBIT_RADIUS_HERO, ORBIT_SPEED_HERO)
end

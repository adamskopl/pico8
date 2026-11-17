MANA = {}
ORBIT_RADIUS_MANA = 4
ORBIT_SPEED_MANA = 0.02

function MANA.add(pos)
  local key = VEC.to_str(pos)
  local mana = ENTITY.new(VEC.cp(pos), nil)
  ANIM.apply_loop(mana, GFX.COIN, GFX.COIN, GFX.COIN + 3, 0.12)
  ANIM.start(mana)
  local existing_mana = mana_orbits[key] and #mana_orbits[key].orbits or 0
  ORBITS.apply(mana, 1 + existing_mana, ORBIT_RADIUS_MANA, ORBIT_SPEED_MANA)
  mana_orbits[key] = mana
end

function MANA.update()
  for _, m in pairs(mana_orbits) do
    ORBITS.update(m)
    ANIM.update(m)
  end
end

function MANA.draw()
  for _, m in pairs(mana_orbits) do
    pal(COLORS.YELLOW, COLORS.BLUE)
    ANIM.draw(m)
    pal()
    ORBITS.draw(m)
  end
end

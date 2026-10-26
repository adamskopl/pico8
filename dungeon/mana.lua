MANA = {}
ORBIT_RADIUS_MANA = 2
ORBIT_SPEED_MANA = 0.02

function MANA.add(pos)
  local key = VEC.to_str(pos)
  local mana = ENTITY.new(VEC.cp(pos), nil)
  local existing_mana = mana_orbits[key] and #mana_orbits[key].orbits or 0
  ORBITS.apply(mana, 1 + existing_mana, ORBIT_RADIUS_MANA, ORBIT_SPEED_MANA)
  mana_orbits[key] = mana
end

function MANA.update()
  for _, m in pairs(mana_orbits) do
    ORBITS.update(m)
  end
end

function MANA.draw()
  for _, m in pairs(mana_orbits) do
    circ(m.pos.x + 4, m.pos.y + 4, ORBIT_RADIUS_MANA + 2, COLORS.WHITE)
    ORBITS.draw(m)
  end
end

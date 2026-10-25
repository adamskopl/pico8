MANA = {}
ORBIT_RADIUS_MANA = 3
ORBIT_SPEED_MANA = 0.02

function MANA.add(pos)
  local key = VEC.to_str(pos)
  local m = ENTITY.new(VEC.cp(pos), nil)
  ORBITS.apply(m, 1, ORBIT_RADIUS_MANA, ORBIT_SPEED_MANA)
  mana_orbits[key] = m
end

function MANA.update()
  for _, m in pairs(mana_orbits) do
    ORBITS.update(m)
  end
end

function MANA.draw()
  for _, m in pairs(mana_orbits) do
    ORBITS.draw(m)
  end
end

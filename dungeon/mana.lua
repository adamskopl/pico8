MANA = {}
ORBIT_RADIUS_MANA = 3
ORBIT_SPEED_MANA = 0.02

function MANA.add(pos)
  for m in all(mana_orbits) do
    if VEC.eq(m.pos, pos) then
      return
    end
  end

  local m = ENTITY.new(VEC.cp(pos), nil)
  ORBITS.apply(m, 1, ORBIT_RADIUS_MANA, ORBIT_SPEED_MANA)
  add(mana_orbits, m)
end

function MANA.update()
  for m in all(mana_orbits) do
    ORBITS.update(m)
  end
end

function MANA.draw()
  for m in all(mana_orbits) do
    ORBITS.draw(m)
  end
end

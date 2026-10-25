MANA = {}
ORBIT_RADIUS_MANA = 2
ORBIT_SPEED_MANA = 0.03

function MANA.add(pos)
  for m in all(mana_orbits) do
    if VEC.eq(m.pos, pos) then
      return
    end
  end

  local m = ENTITY.new(VEC.cp(pos), nil)
  ORBITS.apply(m, 1, ORBIT_RADIUS_MANA, ORBIT_SPEED_MANA, true)
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

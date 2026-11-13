MANA = {}
MANA_TYPE = {
  LEFT = "LEFT",
  COLLECT = "COLLECT",
}
ORBIT_RADIUS_MANA = 2
ORBIT_SPEED_MANA = 0.02

function MANA.add(pos, type)
  local key = VEC.to_str(pos)
  local mana = ENTITY.new(VEC.cp(pos), nil)
  mana.type = type
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
    if m.type == MANA_TYPE.LEFT then
      circ(m.pos.x + 4, m.pos.y + 4, ORBIT_RADIUS_MANA + 1, COLORS.INDIGO)
    elseif m.type == MANA_TYPE.COLLECT then
      spr(GFX.HAT, m.pos.x, m.pos.y)
    end
    ORBITS.draw(m)
  end
end

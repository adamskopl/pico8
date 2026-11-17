MANA = {}
MANA_TYPE = {
  LEFT = "LEFT",
  COLLECT = "COLLECT",
}
ORBIT_RADIUS_MANA = 4
ORBIT_SPEED_MANA = 0.02

function MANA.add(pos, type)
  local key = VEC.to_str(pos)
  local mana = ENTITY.new(VEC.cp(pos), nil)
  mana.type = type
  -- if type == MANA_TYPE.COLLECT then
  --   -- FLOATING.apply(mana, 1)
  -- elseif type == MANA_TYPE.LEFT then
  ANIM.apply_loop(mana, GFX.COIN, GFX.COIN, GFX.COIN + 3, 0.12)
  ANIM.start(mana)
  -- end
  local existing_mana = mana_orbits[key] and #mana_orbits[key].orbits or 0
  ORBITS.apply(mana, 1 + existing_mana, ORBIT_RADIUS_MANA, ORBIT_SPEED_MANA)
  mana_orbits[key] = mana
end

function MANA.update()
  for _, m in pairs(mana_orbits) do
    ORBITS.update(m)
    -- if m.type == MANA_TYPE.LEFT then
    ANIM.update(m)
    -- end
    -- FLOATING.update(m)
  end
end

function MANA.draw()
  for _, m in pairs(mana_orbits) do
    -- if m.type == MANA_TYPE.LEFT then
    pal(COLORS.YELLOW, COLORS.BLUE)
    ANIM.draw(m)
    pal()
    ORBITS.draw(m)
    -- end
    -- elseif m.type == MANA_TYPE.COLLECT then
    --   spr(GFX.POTION, m.pos.x, m.pos.y + (m.floating and m.floating.offset or 0))
    -- end
  end
end

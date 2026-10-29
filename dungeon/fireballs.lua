FIREBALLS = {}

function FIREBALLS.fire()
  local f = ENTITY.new(VEC.cp(hero.pos), VEC.cp(hero.dir))
  MOV.apply(f, 3, false)
  ANIM.apply_loop(f, GFX.FIREBALL, GFX.FIREBALL, GFX.FIREBALL + 3, 0.05)
  MOV.start(f)
  add(fireballs, f)
  sfx(SFX.FIRE)
  CAMERA.shake(0.1, 3)
end

function FIREBALLS.update()
  for i = #fireballs, 1, -1 do
    local f = fireballs[i]
    MOV.update(f)
    ANIM.update(f)
    local wall_pos_m = get_pos_m_facing(f)
    if wall_in_pos_m(wall_pos_m) then
      local mana_pos_m = get_pos_m_mostly_occupied(f)
      MANA.add(VEC.multi(mana_pos_m, 8))
      ANIM.create_single(f.pos, GFX.ENERGY, GFX.ENERGY + 3, 0.06)
      deli(fireballs, i)
      sfx(SFX.CRASH)
    end
  end
end

function FIREBALLS.draw()
  for f in all(fireballs) do
    ANIM.draw(f)
  end
end

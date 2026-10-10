FIREBALLS = {}

function FIREBALLS.fire()
  local f = ENTITY.new(VEC.cp(hero.pos), VEC.cp(hero.dir))
  MOV.apply(f, 3, false)
  ANIM.apply_loop(f, GFX.FIREBALL, GFX.FIREBALL, GFX.FIREBALL + 3, 0.05)
  MOV.start(f)
  add(fireballs, f)
  sfx(SFX.FIRE)
  shake_camera(0.1, 3)
end

function FIREBALLS.update()
  for i = #fireballs, 1, -1 do
    local f = fireballs[i]
    MOV.update(f)
    ANIM.update(f)
    if wall_in_pos_m(pos_to_pos_m(f.pos, f.dir)) then
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

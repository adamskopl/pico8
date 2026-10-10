FIREBALLS = {}

function FIREBALLS.fire()
  local f = ENTITY.new(VEC.cp(hero.pos), VEC.cp(hero.dir))
  MOV.apply(f, 3, false)
  ANIM.apply_loop(f, GFX.FIREBALL, GFX.FIREBALL, GFX.FIREBALL + 3, 0.05)
  MOV.start(f)
  add(fireballs, f)
end

function FIREBALLS.update()
  for f in all(fireballs) do
    MOV.update(f)
    ANIM.update(f)
  end
end

function FIREBALLS.draw()
  for f in all(fireballs) do
    ANIM.draw(f)
  end
end

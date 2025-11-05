function update_p()
  local function update_bullets()
    for b in all(bullets) do
      update_pos(b)

      for pos, t in pairs(lvl) do
        if t.type == MAP.WALL then
          if vec_in_tile(b.pos, t.pos) then
            sfx(SFX.BULL_CRASH)
            del(bullets, b)
          end
        end
      end

      for e in all(enemies) do
        if vec_in_tile(b.pos, e.pos) then
          sfx(SFX.MONSTER_DEATH)
          del(bullets, b)
          del(enemies, e)
        end
      end

      for s in all(swirls) do
        if vec_in_tile(b.pos, s.pos) then
          sfx(SFX.BULL_CRASH)
          del(bullets, b)
        end
      end

      for m in all(mages) do
        if vec_in_tile(b.pos, m.pos) then
          sfx(SFX.MONSTER_DEATH)
          del(bullets, b)
          remove_from_level(m.swirl)
          del(mages, m)
        end
      end

    end
  end

  local function check_collisions()
    local function forColl(o)
      if tiles_small_collide(p.pos, o.pos) then
        sfx(SFX.DEATH)
        _init()
      end
    end
    foreach(enemies, forColl)
    foreach(swirls, forColl)
    foreach(mages, forColl)

  end

  update_bullets()
  check_collisions()
end

function draw_p()
  local function draw_gun()
    local flip = p.dir.x == -1
    local dx = (flip and -3) or 3
    spr(MAP.GUN, p.pos.x + dx, p.pos.y + 5, 1, 1, flip)
  end

  local flip = p.dir.x == -1
  spr(1, p.pos.x, p.pos.y, 1, 1, flip)
  draw_gun()
  if p.dir then
    local len = 8
    --  crosshair
    circ(p.pos.x + 4 + p.dir.x * len,
      p.pos.y + 4 + p.dir.y * len, 1, 8)
  end
end

function shoot()
  sfx(SFX.SHOOT)

  local pos = vec_cp(p.pos)
  pos.y = pos.y + 5
  if p.dir.x == -1 then
    pos.x = pos.x + 2
  elseif p.dir.x == 1 then
    pos.x = pos.x + 5
  else
    pos.x = pos.x + 3
  end

  add(bullets, {
    pos = pos,
    dir = vec_cp(p.dir),
    speed = 4
  })
end

function draw_bullets()
  for b in all(bullets) do
    pset(b.pos.x, b.pos.y, COL.BULLET)
  end
end

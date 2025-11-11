function create_player(o)
  o.m = nil
  o.dir = vec(1, 0)
  o.speed = 1

  o.ammo = {
    ammo = 0,
    show = false,
    t_show = create_timer(0.7, function()
      p.ammo.show = true
    end, function()
      p.ammo.show = false
    end)
  }
end

-- TODO convention. all functions related to something with same prefix
function player_show_ammo()
  start_timer(p.ammo.t_show)
end

function update_player()
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

      for e in all(monsters) do
        if vec_in_tile(b.pos, e.pos) then
          sfx(SFX.MONSTER_DEATH)
          del(bullets, b)
          del(monsters, e)
        end
      end

      for s in all(eyes) do
        if vec_in_tile(b.pos, s.pos) then
          sfx(SFX.BULL_CRASH)
          del(bullets, b)
        end
      end

      for m in all(mages) do
        if vec_in_tile(b.pos, m.pos) then
          sfx(SFX.MONSTER_DEATH)
          del(bullets, b)
          remove_from_level(m.eye)
          del(mages, m)
        end
      end

    end
  end

  local function on_carrot(c)
    sfx(SFX.AMMO_LOAD)
    p.ammo.ammo = 3
    del(carrots, c)
    player_show_ammo()
  end

  local function check_collisions()
    local function forColl(o)
      if tiles_small_collide(p.pos, o.pos) then
        sfx(SFX.DEATH)
        _init()
      end
    end
    foreach(monsters, forColl)
    foreach(eyes, forColl)
    foreach(mages, forColl)
    foreach(carrots, function(c)
      if tiles_small_collide(p.pos, c.pos) then
        on_carrot(c)
      end
    end)
  end
  --------------------------------------------------------------------

  update_timer(p.ammo.t_show)
  update_bullets()
  check_collisions()
end

function draw_p()
  local function draw_gun()
    local flip = p.dir.x == -1
    local dx = (flip and -3) or 3
    spr(MAP.GUN, p.pos.x + dx, p.pos.y + 5, 1, 1, flip)
  end

  local function draw_ammo()
    if (not p.ammo.show) then
      return
    end
    local pos = vec(p.pos.x + 1, p.pos.y - 2, 6)
    local shift = 0
    for i = 1, 3 do
      pset(pos.x + shift, pos.y,
        i <= p.ammo.ammo and COL.AMMO or COL.AMMO_EMPTY)
      shift = shift + 2
    end
  end

  local flip = p.dir.x == -1
  spr(1, p.pos.x, p.pos.y, 1, 1, flip)

  draw_ammo()
  draw_gun()

  if p.dir then
    local len = 8
    --  crosshair
    circ(p.pos.x + 4 + p.dir.x * len,
      p.pos.y + 4 + p.dir.y * len, 1, 8)
  end
end

function shoot()
  if p.ammo.ammo == 0 then
    start_timer(p.ammo.t_show)
    sfx(SFX.NO_AMMO)
    return
  end
  sfx(SFX.SHOOT)
  p.ammo.ammo = p.ammo.ammo - 1
  start_timer(p.ammo.t_show)

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
    pset(b.pos.x, b.pos.y, COL.AMMO)
  end
end

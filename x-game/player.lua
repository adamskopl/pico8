function create_player(o)
  o.m = nil
  o.dir = vec(1, 0)
  o.speed = 1

  o.ammo = {
    ammo = 0,
    show = false,
    t_show = timer_create(0.7, function()
      p.ammo.show = true
    end, function()
      p.ammo.show = false
    end)
  }
  anim_create_loop(o, 96, 97, 100, 0.05)

  o.gun = {
    cooling = false,
    t_cooldown = timer_create(0.6, function()
      p.gun.cooling = true
    end, function()
      p.gun.cooling = false
    end)
  }
  anim_create_single(o.gun, 112, 113, 114, 0.2)
end

function player_show_ammo()
  timer_start(p.ammo.t_show)
end

function update_player()
  local function update_bullets()
    for i = #bullets, 1, -1 do
      local b = bullets[i]
      update_pos(b)

      for pos, t in pairs(lvl) do
        if t.type == MAP.WALL then
          if vec_in_tile(b.pos, t.pos) then
            sfx(SFX.BULL_CRASH)
            deli(bullets, i)
            break
          end
        end
      end

      for e in all(monsters) do
        if vec_in_tile(b.pos, e.pos) then
          sfx(SFX.MONSTER_DEATH)
          deli(bullets, i)
          del(monsters, e)
          splash_spawn(b.pos.x, b.pos.y, 100, 8, 40)
          break
        end
      end

      for eye in all(eyes) do
        if vec_in_tile(b.pos, eye.pos) then
          sfx(SFX.BULL_CRASH)
          deli(bullets, i)
          splash_spawn(b.pos.x, b.pos.y, 10, 5, 5)
          break
        end
      end

      for m in all(mages) do
        if vec_in_tile(b.pos, m.pos) then
          sfx(SFX.MONSTER_DEATH)
          deli(bullets, i)
          remove_from_level(m.eye)
          del(mages, m)

          splash_spawn(m.eye.pos.x, m.eye.pos.y, 100,
            m.eye.col, 40)
          splash_spawn(b.pos.x, b.pos.y, 100, m.col, 40)
          break
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
        splash_spawn(p.pos.x, p.pos.y, 100, COL.PLAYER, 50)
        game.over = true
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

  timer_update(p.ammo.t_show)
  timer_update(p.gun.t_cooldown)
  update_bullets()
  check_collisions()
  anim_update(p)
  anim_update(p.gun)
end

function draw_player()
  local function draw_gun()
    local flip = p.dir.x == -1
    local dx = (flip and -1) or 1
    spr(p.gun.anim.frame, p.pos.x + dx, p.pos.y + 2, 1, 1,
      flip)
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
  ---------------------------------------------

  local flip = p.dir.x == -1
  spr(p.anim.frame, p.pos.x, p.pos.y, 1, 1, flip)

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
  if p.gun.cooling or check_wall_in_dir(p, p.dir) then
    return
  end
  timer_start(p.gun.t_cooldown)

  if p.ammo.ammo == 0 then
    timer_start(p.ammo.t_show)
    sfx(SFX.NO_AMMO)
    return
  end
  sfx(SFX.SHOOT)

  p.ammo.ammo = p.ammo.ammo - 1
  timer_start(p.ammo.t_show)

  anim_start(p.gun)

  --- bullets
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
  --- bullets
end

function draw_bullets()
  for b in all(bullets) do
    pset(b.pos.x, b.pos.y, COL.AMMO)
  end
end

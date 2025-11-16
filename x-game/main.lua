--[[ DICTIONARY
pos - pixel position
m_pos - map position
m - result of mget()
]] function _init()
  printh("--init")
  game = {
    over = false,
    level = LEVELS[2]
  }
  init_debug()
  init_lvl()

  t_key_press = nil
  dt_key_press = 0.1
end

function _update60()
  local dir = (btn(0) and vec(-1, 0)) or
                (btn(1) and vec(1, 0)) or
                (btn(2) and vec(0, -1)) or
                (btn(3) and vec(0, 1)) or nil
  if dir and not p.m then
    if not vec_eq(dir, p.dir) then -- dir change, measure press time
      p.dir = dir
      t_key_press = time()
    elseif t_key_press then -- same dir, but measuring press time
      if time() - t_key_press >= dt_key_press then
        t_key_press = nil
      end
    elseif not check_wall_in_dir(p, dir) then -- same dir, no press time measure
      sfx(SFX.WALK)
      start_movement(p)
      anim_start(p)
    end
  else
    t_key_press = nil
  end

  if (btn(4)) then
    shoot()
  end

  update_lvl()
  update_splashes()
end

function _draw()
  draw_lvl()
  draw_splashes()
end

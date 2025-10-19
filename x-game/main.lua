--[[ 
pos - pixel position
m_pos - map position
]] function _init()
  printh("--init")
  init_debug()
  init_lvl()
  poke(0X5F5C, 100) -- never repeat btnp
end

function _update60()
  local dir = (btnp(0) and vec(-1, 0)) or
                (btnp(1) and vec(1, 0)) or
                (btnp(2) and vec(0, -1)) or
                (btnp(3) and vec(0, 1)) or nil

  if dir and not p.m then
    if not vec_eq(dir, p.dir) then
      p.dir = dir
    else
      sfx(0)
      start_movement(p)
    end
  end

  if (btnp(4)) then
    shoot()
  end

  update_lvl()
end

function _draw()
  draw_lvl()
end

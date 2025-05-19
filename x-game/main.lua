function _init()
  printh("--init")
  init_map()
end

function _update60()
  local dir = (btnp(0) and dir_vec(0)) or (btnp(1) and dir_vec(1)) or
                (btnp(2) and dir_vec(2)) or (btnp(3) and dir_vec(3))
  if dir and not p.m.dir then
    if not vec_eq(dir, p.dir) then
      p.dir = dir
    else
      start_move(p, dir)
    end
  end

  move(p)
  --	update_map()
end

function _draw()
  cls()
  draw_map()
  draw_enemies()
  draw_p()
end

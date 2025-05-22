function _init()
  printh("--init")
  init_map()
end

function _update60()
  local dir = (btnp(0) and {
    x = -1,
    y = 0
  }) or (btnp(1) and {
    x = 1,
    y = 0
  }) or (btnp(2) and {
    x = 0,
    y = -1
  }) or (btnp(3) and {
    x = 0,
    y = 1
  }) or nil

  if dir and not p.m then
    if (not p.dir) or (not vec_eq(dir, p.dir)) then
      p.dir = dir
    else
      start_move(p, dir)
    end
  end

  move(p)
  update_map()
end

function _draw()
  cls(0)
  draw_map()
  draw_enemies()
  draw_p()
end

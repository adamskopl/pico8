function _init()
  printh("--init")
  init_lvl()
end

function _update60()
  local dir = (btn(0) and vec(-1, 0)) or
                (btn(1) and vec(1, 0)) or
                (btn(2) and vec(0, -1)) or
                (btn(3) and vec(0, 1)) or nil

  if dir and not p.m then
    if (not p.dir) or (not vec_eq(dir, p.dir)) then
      p.dir = dir
    else
      sfx(0)
      start_move(p)
    end
  end

  update_lvl()
end

function _draw()
  draw_lvl()
end

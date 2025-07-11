local function draw_gun()
  local flip = (p.dir and (p.dir.x == -1)) or false
  local dx = (flip and -7) or 7
  spr(5, p.pos.x + dx, p.pos.y + 4, 1, 1, flip)
end

function draw_p()
  spr(1, p.pos.x, p.pos.y)
  draw_gun()
  if p.dir then
    local len = 5
    -- crosshair
    -- circ(p.pos.x + 4 + p.dir.x * len,
    --   p.pos.y + 4 + p.dir.y * len, 1, 8)
  end
end

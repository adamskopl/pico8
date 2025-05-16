function draw_p()
  spr(1, p.x - 4, p.y - 4)
  draw_aim()
end

function draw_aim()
  local diam = 8
  local dx = cos(p.aim) * diam
  local dy = sin(p.aim) * diam
  circ(p.x + dx, p.y + dy, 1, 8)
end

function update_p()
  update_aim()
end

function update_aim()
  local dx = (btn(1) and 1 or 0) - (btn(0) and 1 or 0)
  local dy = (btn(3) and 1 or 0) - (btn(2) and 1 or 0)
  if dx == 0 and dy == 0 then
    return
  end
  local target = atan2(dx, dy)
  local step = 0.01
  local diff = (target - p.aim + 1) % 1
  if diff == 0 then
    return
  elseif diff < 0.5 then
    p.aim = (p.aim + step) % 1 -- clockwise
  else
    p.aim = (p.aim - step + 1) % 1 -- counterclockwise
  end

end


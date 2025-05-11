function _init()
  printh("--init--")
  p = {
    x = 50,
    y = 50,
    speed = 1
  }
  objs = {{
    x = 0,
    y = 0,
    active = false
  }, {
    x = 50,
    y = 25,
    active = false
  }, {
    x = 100,
    y = 0,
    active = false
  }, {
    x = 100,
    y = 50,
    active = false
  }, {
    x = 100,
    y = 100,
    active = false
  }, {
    x = 50,
    y = 100,
    active = false
  }, {
    x = 0,
    y = 100,
    active = false
  }, {
    x = 0,
    y = 50,
    active = false
  }}
  target = nil
end

function _update60()
  if btnp(0) then
    cycle_target(1)
  elseif btnp(1) then
    cycle_target(-1)
  elseif btn(2) then
    move_towards(p, target)
  elseif btn(3) then
  end
end

function _draw()
  cls()
  draw_lines_to_objs()

  for o in all(objs) do
    pset(o.x, o.y, o.active and 11 or 8)
  end
  draw_p()
end

function draw_p()

  spr(1, p.x, p.y)
end

function move_towards(o, target)
  local dx = target.x - o.x
  local dy = target.y - o.y
  local distance = sqrt(dx ^ 2 + dy ^ 2)
  local dir_x = dx / distance
  local dir_y = dy / distance
  if distance < o.speed then
    o.x = target.x
    o.y = target.y
  else
    o.x = o.x + dir_x * o.speed
    o.y = o.y + dir_y * o.speed
  end
end

function draw_lines_to_objs()
  for o in all(objs) do
    line(p.x, p.y, o.x, o.y, o.active and 13 or 9)
  end
end

function angle_between(from, to)
  local dx = to.x - from.x
  local dy = to.y - from.y
  return atan2(dx, dy)
end

function angle_diff_cw(from, to, dir)
  local diff = ((to - from) * dir) % 1
  return diff == 0 and 1 or diff -- skip exact same angle
end

function cycle_target(dir)
  local angle_from = target and angle_between(p, target) or 0
  local next_obj = nil
  local min_diff = 1 -- full circle

  for obj in all(objs) do
    if obj ~= target then
      local angle_to = angle_between(p, obj)
      local diff = angle_diff_cw(angle_from, angle_to, dir)
      printh(diff)
      if diff < min_diff then
        min_diff = diff
        next_obj = obj
      end
    end
  end

  if target then
    target.active = false
  end
  target = next_obj
  target.active = true
end

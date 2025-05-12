function _init()
  printh("--init--")
  cfg = {
    mode = 1 -- 0=angles, 1=arrows
  }
  p = {
    x = 1 * 8,
    y = 1 * 8,
    speed = 1
  }
  init_map()
  target = nil
end

function _update60()
  if cfg.mode == 0 then
    if btnp(0) then
      cycle_target(1)
    elseif btnp(1) then
      cycle_target(-1)
    elseif btn(2) then
      move_towards(p, target)
    elseif btn(3) then
    end
  elseif cfg.mode == 1 then
    if btn(0) then
      p.x = p.x - p.speed
      aim(-1, 0)
    elseif btn(1) then
      p.x = p.x + p.speed
      aim(1, 0)
    elseif btn(2) then
      p.y = p.y - p.speed
      aim(0, -1)
    elseif btn(3) then
      p.y = p.y + p.speed
      aim(0, 1)
    end
  end
  if btnp(4) then
    shoot()
  end

  for e in all(enemies) do
    move_towards(e, p)
  end

  for b in all(bullets) do
    local hit = move_towards(b, {
      x = b.target.x + 3,
      y = b.target.y + 3
    })
    if hit then
      sfx(0)
      del(bullets, b)
      del(enemies, b.target)
      target = nil
    end
  end
end

function _draw()
  cls()
  map(0, 0, 0, 0, 16, 16, 1)
  if target then
    rect(target.x, target.y, target.x + 8, target.y + 8, 12)
  end
  -- draw_lines_to_objs()
  for e in all(enemies) do
    spr(6, e.x, e.y)
  end

  draw_p()
  for b in all(bullets) do
    pset(b.x, b.y, 8)
  end

end

function draw_p()
  spr(1, p.x, p.y)
end

function normalize(x, y)
  local len = sqrt(x * x + y * y)
  if len == 0 then
    return 0, 0
  end
  return x / len, y / len
end

function aim(dx, dy)
  local closest = nil
  local min_dist = 9999

  for e in all(enemies) do
    -- vector to enemy
    local vx = e.x - p.x
    local vy = e.y - p.y

    -- normalize it
    local nvx, nvy = normalize(vx, vy)

    -- dot product with direction
    local dot = dx * nvx + dy * nvy

    if dot >= 0 then
      local dist = vx * vx + vy * vy -- squared distance
      if dist < min_dist then
        min_dist = dist
        closest = e
      end
    end
  end

  target = closest
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
    return true
  else
    o.x = o.x + dir_x * o.speed
    o.y = o.y + dir_y * o.speed
  end
  return false
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

  for obj in all(enemies) do
    if obj ~= target then
      local angle_to = angle_between(p, obj)
      local diff = angle_diff_cw(angle_from, angle_to, 1)
      if diff < min_diff then
        min_diff = diff
        next_obj = obj
      end
    end
  end

  target = next_obj
end

function shoot()
  if not target then
    return
  end
  local bullet = {
    x = p.x + 3,
    y = p.y + 3,
    speed = 10,
    target = target
  }
  add(bullets, bullet)
end

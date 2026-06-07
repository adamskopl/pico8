function mov_init(o, pos)
  o.pos = pos
  o.dir = nil
  o.speed = 1
  o.mov = {
    on = false,
    pos_start = nil
  }
end

function mov_moving(o)
  return o.mov.on
end

function mov_start(o)
  o.mov.on = true
  o.mov.pos_start = VEC.new(o.pos.x, o.pos.y)
end

function mov_update(o)
  if not o.mov.on then
    return
  end
  o.pos.x = o.pos.x + o.dir.x * o.speed
  o.pos.y = o.pos.y + o.dir.y * o.speed
  -- assuming speed is a divisor of 8
  if abs(o.mov.pos_start.x - o.pos.x) == 8 or abs(o.mov.pos_start.y - o.pos.y) == 8 then
    o.mov.on = false
    o.mov.pos_start = nil
  end
end

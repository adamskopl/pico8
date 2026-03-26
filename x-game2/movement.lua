MOV = {}

function MOV.init(o, pos)
  o.pos = pos
  o.dir = VEC.from(1, 0)
  o.speed = 1
  o.mov = {
    on = false,
    pos_start = nil
  }
end

function MOV.is_moving(o)
  return o.mov.on
end

function MOV.start(o)
  o.mov.on = true
  o.mov.pos_start = VEC.from(o.pos.x, o.pos.y)
  ANIM.start(o)
end

function MOV.update(o)
  if not MOV.is_moving(o) then return end
  o.pos.x = o.pos.x + o.dir.x * o.speed
  o.pos.y = o.pos.y + o.dir.y * o.speed
  -- assuming speed is divisor of 1
  if abs(o.mov.pos_start.x - o.pos.x) == 8 or
      abs(o.mov.pos_start.y - o.pos.y) == 8 then
    o.mov.on = false
    ANIM.stop(o)
  end
end

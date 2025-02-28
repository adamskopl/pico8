MOV = {}

function MOV.init(o, vec)
  o.vec = vec
  o.dir = VEC.from(1, 0)
  o.speed = 1
  o.mov = {
    on = false,
    vec_start = nil
  }
end

function MOV.is_moving(o)
  return o.mov.on
end

function MOV.start(o)
  local map_dir = VEC.add(o.vec, VEC.multi(o.dir, 8))
  if LVL.is_wall(map_dir) then return end

  o.mov.on = true
  o.mov.vec_start = VEC.from(o.vec.x, o.vec.y)
  ANIM.start(o)
end

function MOV.update(o)
  if not MOV.is_moving(o) then return end
  o.vec.x = o.vec.x + o.dir.x * o.speed
  o.vec.y = o.vec.y + o.dir.y * o.speed
  -- assuming speed is divisor of 1
  if abs(o.mov.vec_start.x - o.vec.x) == 8 or
      abs(o.mov.vec_start.y - o.vec.y) == 8 then
    o.mov.on = false
    ANIM.stop(o)
  end
end

function wall_dir(o)
  local pos_m = VEC.div(o.pos, 8)
  local pos_m_dir = VEC.add(pos_m, o.dir)
  if m_offscreen(pos_m_dir) then
    return true
  end
  local m = mget(pos_m_dir.x, pos_m_dir.y)
  return fget(m, FLAGS.WALL)
end

function m_offscreen(pos_m)
  return pos_m.x < 0 or pos_m.x > 15 or pos_m.y < 0 or pos_m.y > 15
end

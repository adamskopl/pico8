function wall_in_dir(o)
  local pos_m = VEC.div(o.pos, 8)
  local pos_m_dir = VEC.add(pos_m, o.dir)
  local m = mget(pos_m_dir.x, pos_m_dir.y)
  return fget(m, FLAGS.WALL)
end

function m_offscreen(pos_m)
  return (pos_m.x < G.level.pos.x) or (pos_m.x > G.level.pos.x + 15) or
           (pos_m.y < G.level.pos.y) or (pos_m.y > G.level.pos.y + 15)
end

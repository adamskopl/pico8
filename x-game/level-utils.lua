function check_wall_in_dir(o, dir)
  local m_pos = vec(p.pos.x / 8, p.pos.y / 8)
  local m_pos_next = vec_add(m_pos, dir)
  return mget(m_pos_next.x, m_pos_next.y) == MAP.WALL
end

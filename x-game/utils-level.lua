function target_tile_for(dir)
  local m_x = flr(a.pos.x / 8)
  local m_y = flr(a.pos.y / 8)
  if dir.x == -1 then
    m_x = max(0, m_x - 1)
  end
  if dir.x == 1 then
    m_x = min(15, m_x + 1)
  end
  if dir.y == -1 then
    m_y = max(0, m_y - 1)
  end
  if dir.y == 1 then
    m_y = min(15, m_y + 1)
  end
  return m_x, m_y
end

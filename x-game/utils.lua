-- utils
function vec_eq(v1, v2)
  return v1.x == v2.x and v1.y == v2.y
end

function dir_vec(dir)
  if dir == 0 then
    return {
      x = -1,
      y = 0
    }
  end
  if dir == 1 then
    return {
      x = 1,
      y = 0
    }
  end
  if dir == 2 then
    return {
      x = 0,
      y = -1
    }
  end
  if dir == 3 then
    return {
      x = 0,
      y = 1
    }
  end
end

function touching(a, b)
  return (a.x == b.x and abs(a.y - b.y) == 8) or (a.y == b.y and abs(a.x - b.x) == 8)
end

function m_dir(m_x, m_y, dir)
  if dir == 0 then
    m_x = m_x - 1
  end
  if dir == 1 then
    m_x = m_x + 1
  end
  if dir == 2 then
    m_y = m_y - 1
  end
  if dir == 3 then
    m_y = m_y + 1
  end
  return m_x, m_y
end

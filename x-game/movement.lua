function start_move(o)
  local m_x = flr(o.pos.x / 8)
  local m_y = flr(o.pos.y / 8)

  if o.dir.x == -1 then
    m_x = max(0, m_x - 1)
  end
  if o.dir.x == 1 then
    m_x = min(15, m_x + 1)
  end
  if o.dir.y == -1 then
    m_y = max(0, m_y - 1)
  end
  if o.dir.y == 1 then
    m_y = min(15, m_y + 1)
  end

  local t = lvl[pos_key(vec(m_x * 8, m_y * 8))]
  local coll = t and (t.type == 'W')

  if not coll then
    local m = {}
    o.m = m
    m.start = {
      x = o.pos.x,
      y = o.pos.y
    }
    m.dir = o.dir
  end
end

function move(o)
  if not o.m then
    return
  end
  local dir = o.m.dir
  if dir then
    o.pos.x = o.pos.x + dir.x * o.speed
    o.pos.y = o.pos.y + dir.y * o.speed
  end
  if abs(o.m.start.x - o.pos.x) == 8 or
    abs(o.m.start.y - o.pos.y) == 8 then
    o.m = nil
  end
end

-- movement
function start_move(o, dir)
  local m_x = flr(o.pos.x / 8)
  local m_y = flr(o.pos.y / 8)

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
  local m = mget(m_x, m_y)
  local coll_f = fget(m, 0)

  if coll_f then
  else
    local m = {}
    o.m = m
    m.start = {
      x = o.pos.x,
      y = o.pos.y
    }
    m.dir = dir
  end
end

function move(o)
  if not o.m then
    return
  end
  local dir = o.m.dir
  if dir then
    o.pos.x = o.pos.x + dir.x * 1
    o.pos.y = o.pos.y + dir.y * 1
  end
  if abs(o.m.start.x - o.pos.x) == 8 or
    abs(o.m.start.y - o.pos.y) == 8 then
    o.m = nil
  end
end

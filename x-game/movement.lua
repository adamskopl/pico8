function start_movement(o)
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

  local t = lvl[vec_key(vec(m_x * 8, m_y * 8))]
  local coll = t and (t.type == MAP.WALL)

  if not coll then
    local m = {}
    o.m = m
    m.start = {
      x = o.pos.x,
      y = o.pos.y
    }
  end
end

function update_movement(o)
  if not o.m then
    return
  end
  if o.dir then
    update_pos(o)
  end
  if abs(o.m.start.x - o.pos.x) == 8 or
    abs(o.m.start.y - o.pos.y) == 8 then
    o.m = nil
    on_mov_end(o)
  end
end

function update_pos(o)
  o.pos.x = o.pos.x + o.dir.x * o.speed
  o.pos.y = o.pos.y + o.dir.y * o.speed
end

function on_mov_end(o)
  init_debug()
  if (o == p) then
    player_enemies_scan()
  end
end

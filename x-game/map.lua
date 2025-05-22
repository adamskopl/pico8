-- map
function init_level()
  level = {}
  doors = {}
  p = {
    pos = {
      x = -1,
      y = -1
    },
    m = nil,
    dir = nil
  }
  enemies = {}
  m_highl = {}
  m_known = {}
  for i = 0, 15 do
    for j = 0, 15 do
      local m = mget(i, j)
      if m == 1 then -- player
        p.pos = {
          x = i * 8,
          y = j * 8
        }
        m_known[pos_key(p.pos)] = {
          pos = vec_cp(p.pos)
        }
      end
      if m == 2 or m == 4 then
        level[pos_key({
          x = i * 8,
          y = j * 8
        })] = {
          type = m == 2 and 'W' or 'D',
          pos = {
            x = i * 8,
            y = j * 8
          },
          known = false
        }
      end
    end
  end
end

function update_level()
  light_corridor()
  discover_level_known()
  discover_walls()
end

function light_corridor()
  m_highl = {}
  if not p.dir then
    return
  end

  local m_x, m_y = p.pos.x / 8, p.pos.y / 8
  local m_pos = {
    x = (p.dir.x == -1 and ceil(m_x)) or
      (p.dir.x == 1 and flr(m_x)) or m_x,
    y = (p.dir.y == -1 and ceil(m_y)) or
      (p.dir.y == 1 and flr(m_y)) or m_y
  }
  m_pos = vec_add(m_pos, p.dir)

  local m = mget(m_pos.x, m_pos.y)

  while m ~= 2 do
    add(m_highl, {
      pos = {
        x = m_pos.x * 8,
        y = m_pos.y * 8
      }
    })
    m_pos = vec_add(m_pos, p.dir)
    m = mget(m_pos.x, m_pos.y)
  end
end

function discover_level_known()
  for m_h in all(m_highl) do
    if not m_known[pos_key(m_h.pos)] then
      m_known[pos_key(m_h.pos)] = {
        pos = vec_cp(m_h.pos)
      }
    end
  end
end

function discover_walls()
  local dirs = {{
    x = -8,
    y = 0
  }, {
    x = 8,
    y = 0
  }, {
    x = 0,
    y = -8
  }, {
    x = 0,
    y = 8
  }}

  if p.dir then
    local m = level[pos_key(vec_add(p.pos,
      vec_multi(p.dir, 8)))]
    if m and m.type == 'W' then
      m.known = true
    end
  end

  for m_h in all(m_highl) do
    for dir in all(dirs) do
      local m = level[pos_key(vec_add(m_h.pos, dir))]
      if m and m.type == 'W' then
        m.known = true
      end
    end
  end
end

function draw_level()
  draw_level_fog()
  draw_visible()

  for pos, t in pairs(level) do
    if t.type == 'W' and t.known then
      spr(2, t.pos.x, t.pos.y)
    end
  end

end

function draw_level_fog()
  for pos, m in pairs(m_known) do
    if not vec_eq(m.pos, p.pos) then
      spr(3, m.pos.x, m.pos.y)
    end
  end
end

function draw_visible()
  local function draw(pos)
    rectfill(pos.x, pos.y, pos.x + 7, pos.y + 7, 4)
  end
  if not p.m then
    draw(p.pos)
  end
  for m_h in all(m_highl) do
    draw(m_h.pos)
    local m = level[pos_key(m_h.pos)]
    if m then
      if m.type == 'D' then
        spr(4, m_h.pos.x, m_h.pos.y)
      end
    end
  end
end

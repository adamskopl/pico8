-- map
function init_map()
  walls = {}
  p = {
    pos = {
      x = -1,
      y = -1
    },
    m = {},
    dir = {
      x = 0,
      y = 0
    }
  }
  enemies = {}
  m_highl = {}
  for i = 0, 15 do
    for j = 0, 15 do
      local m = mget(i, j)
      if m == 1 then
        p.pos = {
          x = i * 8,
          y = j * 8
        }
      end
      if m == 2 then
        add(walls, {
          pos = {
            x = i * 8,
            y = j * 8
          },
          know = false
        })
      end
      if m == 3 then
        add(enemies, {
          pos = {
            x = i * 8,
            y = j * 8
          }
        })
      end
    end
  end
end

function update_map()
  -- mark corridor
  --	m_highl={}
  --	if not p.dir then return end
  --	
  --	
  --	local m_x, m_y = m_dir(
  --		flr(p.x/8), flr(p.y/8), p.dir)
  --	local m=mget(m_x, m_y)
  --	while m != 2 do
  --		add(m_highl, {m_x=m_x,m_y=m_y})
  --		m_x
  --		, m_y = m_dir(
  --			m_x, m_y, p.dir)
  --		m=mget(m_x, m_y)
  --	end
end

function draw_map()
  for m_h in all(m_highl) do
    rectfill(m_h.m_x * 8, m_h.m_y * 8, m_h.m_x * 8 + 7, m_h.m_y * 8 + 7, 15)
  end

  for i = 0, 15 do
    for j = 0, 15 do
      local m = mget(i, j)
      if m == 0 then

      end
      if m == 2 then
      end

      if draw then
        spr(m, i * 8, j * 8)
      end
    end
  end
end

function draw_walls()
  for w in all(walls) do
    if not w.know then
      return
    end
    spr(2, w.x, w.y)
  end
end

function init_lvl()
  lvl = {}
  lvl_visible = {}
  lvl_discovered = {}
  p = nil
  enemies = {}
  bullets = {}

  for i = 0, 15 do
    for j = 0, 15 do
      local m = mget(i, j)
      local o
      if m == 1 then
        p = {
          pos = vec(i * 8, j * 8),
          m = nil,
          dir = vec(1, 0),
          speed = 1
        }
      elseif m == 2 then -- TODO magic number
        o = {
          type = 'W' -- TODO magic number
        }
      elseif m == 4 then
        o = {
          type = 'D'
        }
      elseif m == 17 then
        add(enemies, {
          pos = vec(i * 8, j * 8),
          m = nil,
          dir = vec(-1, 0),
          speed = 0.5
        })
      end
      if o then
        o.pos = vec(i * 8, j * 8)
        lvl[v_key(o.pos)] = o
      end
    end
  end
end

local function mrk_lvl_discovered()
  if not p.m and p.dir then
    local pos_dir = vec_add(p.pos, vec_multi(p.dir, 8))
    lvl_discovered[v_key(pos_dir)] = vec_cp(pos_dir)
  end

  for key, pos in pairs(lvl_visible) do
    lvl_discovered[v_key(pos)] = vec_cp(pos)
  end
end

local function mark_lvl_visible()
  lvl_visible = {}
  if not p.dir then
    return
  end

  local m_x, m_y = p.pos.x / 8, p.pos.y / 8
  local m_pos = vec((p.dir.x == -1 and ceil(m_x)) or
                      (p.dir.x == 1 and flr(m_x)) or m_x,
    (p.dir.y == -1 and ceil(m_y)) or
      (p.dir.y == 1 and flr(m_y)) or m_y)
  local m_pos_next = vec_add(m_pos, p.dir)
  local m_next = mget(m_pos_next.x, m_pos_next.y)
  while m_next ~= 2 do -- TODO magic number
    local pos = vec(m_pos_next.x * 8, m_pos_next.y * 8)
    -- mark next tile as visible and all around it
    lvl_visible[v_key(pos)] = pos
    for dir in all(DIRS) do
      local pos_dir = vec_add(pos, dir)
      lvl_visible[v_key(pos_dir)] = pos_dir
    end
    m_pos_next = vec_add(m_pos_next, p.dir)
    m_next = mget(m_pos_next.x, m_pos_next.y)
  end
end

function update_lvl()
  mark_lvl_visible()
  mrk_lvl_discovered()
  update_enemies()
  update_bullets()
  move(p)
end

--[[ 
	TODO draw level algorithm:
	OR make functions to make this procedure easier tto read

]]
function draw_lvl()
  cls(CFG.COL_GROUND)

  -- draw lvl all
  for pos, t in pairs(lvl) do
    if t.type == 'W' then
      spr(2, t.pos.x, t.pos.y)
    elseif t.type == 'D' then
      spr(4, t.pos.x, t.pos.y)
    end
  end

  draw_enemies()
  draw_bullets()

  -- cover lvl not discovered
  for i = 0, 15 do
    for j = 0, 15 do
      local pos = vec(i * 8, j * 8)
      if not lvl_discovered[v_key(pos)] then
        rectfill(pos.x, pos.y, pos.x + 7, pos.y + 7, 0) -- TODO magic number
      elseif not lvl_visible[v_key(pos)] then
        -- repeat render with a fog of war cover
        local t = lvl[v_key(pos)]
        if (t) then
          if t.type == 'W' then
            pal(11, 5) -- TODO magic numbers
            pal(4, 0)
            spr(2, t.pos.x, t.pos.y)
            pal()
          elseif t.type == 'D' then
            pal(6, 0)
            spr(4, t.pos.x, t.pos.y)
            pal()
          end
        else
          rectfill(pos.x, pos.y, pos.x + 7, pos.y + 7, 5)
        end
        -- spr(3, pos.x, pos.y)
      end
    end
  end

  draw_p()

end

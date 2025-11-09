function init_lvl()
  local function pair_mages()
    local m_index = 1
    for m in all(mages) do
      local eye = eyes[m_index]
      local col = COL.MAGES[m_index]
      m.eye = eye
      m.col = col
      eye.col = col
      m_index = m_index + 1
    end
  end
  ---------------------------------------------------
  lvl = {} -- [pos]:object
  lvl_visible = {}
  lvl_discovered = {}
  p = nil
  enemies = {}
  bullets = {}
  eyes = {}
  mages = {}
  carrots = {}

  for i = 0, 15 do
    for j = 0, 15 do
      local m = mget(i, j)
      local o = {
        type = m,
        pos = vec(i * 8, j * 8)
      }
      if m == MAP.PLAYER then
        create_player(o)
        p = o
      elseif m == MAP.MONSTER then
        create_enemy(o)
        add(enemies, o)
      elseif m == MAP.MAGE then
        add(mages, o)
      elseif m == MAP.CARROT then
        add(carrots, o)
      elseif m == MAP.WALL or m == MAP.EYE then
        lvl[vec_key(o.pos)] = o
        if m == MAP.EYE then
          add(eyes, o)
        end
      end
    end
  end

  pair_mages()
end

function remove_from_level(o)
  lvl[vec_key(o.pos)] = nil
  if o.type == MAP.EYE then
    del(eyes, o)
  end
end

function mark_lvl_visible()
  local function add_to_visible(pos)
    lvl_visible[vec_key(pos)] = pos
    lvl_discovered[vec_key(pos)] = pos
  end
  ------------------------------
  lvl_visible = {}

  local m_x, m_y = p.pos.x / 8, p.pos.y / 8
  local m_pos = vec((p.dir.x == -1 and ceil(m_x)) or
                      (p.dir.x == 1 and flr(m_x)) or m_x,
    (p.dir.y == -1 and ceil(m_y)) or
      (p.dir.y == 1 and flr(m_y)) or m_y)
  local m_pos_next = vec_add(m_pos, p.dir)
  local m_next = mget(m_pos_next.x, m_pos_next.y)

  add_to_visible(vec_multi(m_pos_next, 8)) -- always add first (could be a wall)
  while m_next ~= MAP.WALL do
    local pos = vec_multi(m_pos_next, 8)
    -- mark next tile as visible and all around it (will also include player)
    add_to_visible(pos)
    for dir8 in all(DIRS_8) do
      add_to_visible(vec_add(pos, dir8))
    end
    m_pos_next = vec_add(m_pos_next, p.dir)
    m_next = mget(m_pos_next.x, m_pos_next.y)
  end
end

function update_lvl()
  mark_lvl_visible()
  update_enemies()
  update_player()
  update_movement(p)
end

function draw_lvl()
  local function cover_lvl_not_discovered()
    for i = 0, 15 do
      for j = 0, 15 do
        local pos = vec(i * 8, j * 8)
        if not lvl_discovered[vec_key(pos)] then
          rectfill(pos.x, pos.y, pos.x + 7, pos.y + 7, 0)
        elseif not lvl_visible[vec_key(pos)] then
          -- rerender with a fog of war cover
          local t = lvl[vec_key(pos)]
          if (t) then
            if t.type == MAP.WALL then
              pal(11, 5) -- TODO magic numbers
              spr(MAP.WALL, t.pos.x, t.pos.y)
              pal()
            elseif t.type == MAP.EYE then
              pal(7, 0)
              spr(MAP.EYE, t.pos.x, t.pos.y)
              pal()
            end
          else
            rectfill(pos.x, pos.y, pos.x + 7, pos.y + 7,
              COL.GROUND)
            spr(MAP.FOG, pos.x, pos.y)
          end
        end
      end
    end
  end

  local function draw_mages_and_eyes()
    for m in all(mages) do
      local eye = m.eye
      pal(7, m.col)
      spr(MAP.MAGE, m.pos.x, m.pos.y)
      spr(MAP.EYE, eye.pos.x, eye.pos.y)
      pal()
    end
  end

  local function draw_carrots()
    for c in all(carrots) do
      spr(MAP.CARROT, c.pos.x, c.pos.y)
    end
  end
  -----------------------------------------------------------------
  cls(COL.GROUND)
  -- draw lvl static elements all
  for pos, t in pairs(lvl) do
    if t.type == MAP.EYE then
      pal(7, t.col)
    end
    spr(t.type, t.pos.x, t.pos.y)
    pal()
  end
  draw_enemies()
  draw_mages_and_eyes()
  draw_carrots()
  draw_bullets()
  if not CFG.DEBUG then
    cover_lvl_not_discovered()
  end
  draw_p()

  if CFG.DEBUG then
    draw_debug()
  end
end

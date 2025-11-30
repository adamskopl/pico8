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
  monsters = {}
  bullets = {}
  eyes = {}
  mages = {}
  carrots = {}

  for i = 0, 15 do
    for j = 0, 15 do
      local m = mget(i + LEVELS[game.level_idx].x,
        j + LEVELS[game.level_idx].y)
      local o = {
        type = m,
        pos = vec(i * 8, j * 8)
      }
      if m == MAP.PLAYER then
        create_player(o)
        p = o
      elseif m == MAP.MONSTER then
        monster_create(o)
        add(monsters, o)
      elseif m == MAP.MAGE then
        local interval = 1 + rnd(1)
        anim_create_cont_reverse(o, 80, 82, 0.1, interval)
        add(mages, o)
      elseif m == MAP.CARROT then
        add(carrots, o)
      elseif m == MAP.WALL or m == MAP.EYE then
        lvl[vec_key(o.pos)] = o
        if m == MAP.EYE then
          local interval = 1 + rnd(3)
          anim_create_cont_reverse(o, 64, 67, 0.05, interval)
          add(eyes, o)
        end
      end
    end
  end

  pair_mages()
end

function clean_level()
  lvl = {}
  bullets = {}
  p.ammo.ammo = 0
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
  local m_next = lget(m_pos_next.x, m_pos_next.y)

  add_to_visible(vec_multi(m_pos_next, 8)) -- always add first (could be a wall)
  while m_next ~= MAP.WALL do
    local pos = vec_multi(m_pos_next, 8)
    -- mark next tile as visible and all around it (will also include player)
    add_to_visible(pos)
    for dir8 in all(DIRS_8) do
      add_to_visible(vec_add(pos, dir8))
    end
    m_pos_next = vec_add(m_pos_next, p.dir)
    m_next = lget(m_pos_next.x, m_pos_next.y)
  end
end

function update_lvl()
  if game.state ~= STATE_WIN then
    mark_lvl_visible()
  end
  update_enemies()

  if game.state ~= STATE_OVER then
    update_player()
    update_movement(p)
  end
end

function draw_lvl()
  local function cover_lvl_not_discovered()
    for i = 0, 15 do
      for j = 0, 15 do
        local pos = vec(i * 8, j * 8)
        if not lvl_discovered[vec_key(pos)] then
          rectfill(pos.x, pos.y, pos.x + 7, pos.y + 7,
            COL.UNDISCOVERED)
        elseif not lvl_visible[vec_key(pos)] or game.state ==
          STATE_OVER then
          -- rerender with a fog of war cover
          local t = lvl[vec_key(pos)]
          if (t) then
            if t.type == MAP.WALL then
              pal(11, 5) -- TODO magic numbers
              spr(MAP.WALL, t.pos.x, t.pos.y)
              pal()
            elseif t.type == MAP.EYE then
              pal(7, 0)
              spr(t.anim.frame, t.pos.x, t.pos.y)
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

  local function draw_mages()
    for m in all(mages) do
      pal(7, m.col)
      spr(m.anim.frame, m.pos.x, m.pos.y)
      pal()
    end
  end

  local function draw_carrots()
    for c in all(carrots) do
      spr(MAP.CARROT, c.pos.x, c.pos.y)
    end
  end

  local function draw_exposed()
    for e in all(monsters) do
      if e.exposed then
        spr(e.anim.frame, e.pos.x, e.pos.y)
      end
    end
  end
  -----------------------------------------------------------------
  cls(game.state == STATE_WIN and COL.GROUND_WIN or
        COL.GROUND)
  flowers_draw()
  -- draw lvl static elements all
  if game.state ~= STATE_WIN then
    for pos, t in pairs(lvl) do
      if t.type == MAP.EYE then
        pal(7, t.col)
        spr(t.anim.frame, t.pos.x, t.pos.y)
        pal()
      else
        spr(t.type, t.pos.x, t.pos.y)
      end
    end
  end
  draw_enemies()
  draw_mages()
  draw_carrots()
  draw_bullets()
  if not CFG.DEBUG and game.state ~= STATE_WIN then
    cover_lvl_not_discovered()
  end
  draw_exposed()

  if game.state ~= STATE_OVER then
    draw_player()
  end

  if CFG.DEBUG then
    draw_debug()
  end
end

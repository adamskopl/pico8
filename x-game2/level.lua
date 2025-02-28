LVL = {}

-- ===== get/set =====--
function LVL.get(vec)
  return mget(vec.x / 8, vec.y / 8)
end

function LVL.set(vec, val)
  return mset(vec.x / 8, vec.y / 8, val)
end

-- ===== global utils =====--
function LVL.is_wall(vec)
  return MAP.WALL_ALL[LVL.get(vec)]
end

-- ===== local helpers ======--
local function map_each(cb)
  for x = G.level.vec_start.x, G.level.vec_end.x do
    for y = G.level.vec_start.y, G.level.vec_end.y do
      cb(mget(x, y), VEC.from(x * 8, y * 8))
    end
  end
end

-- ===== walls =====--
local function wall_update_sprite(_, vec)
  if not LVL.is_wall(vec) then
    return
  end
  local neigh_cnt = 0
  local neigh = {}
  for d in all(DIRS_8) do
    local v_dir = VEC.add(vec, d)
    if LVL.is_wall(v_dir) then
      neigh_cnt = neigh_cnt + 1
      neigh[VEC.key(d)] = true
    end
  end
  local up = neigh['0_-8']
  local right = neigh['8_0']
  local down = neigh['0_8']
  local left = neigh['-8_0']

  local sprites = nil
  if neigh_cnt == 1 then
    if up then
      sprites = MAP.WALL_UD
    elseif down then
      sprites = MAP.WALL_LR
    end
  elseif neigh_cnt == 2 then
    -- corners
    if down and left then -- UR
      sprites = MAP.WALL_UR
    elseif up and left then -- DR
      sprites = MAP.WALL_DR
    elseif right and up then -- DL
      sprites = MAP.WALL_DL
    elseif right and down then -- UL
      sprites = MAP.WALL_UL
    elseif up and down and not left and not right then
      sprites = MAP.WALL_LR
    elseif left and right and not up and not down then
      sprites = MAP.WALL_UD
    end
  elseif neigh_cnt == 3 then
    if down then
      sprites = MAP.WALL_LR
    elseif up then
      sprites = MAP.WALL_UD
    end
  end
  if sprites then
    LVL.set(vec, tbl_get_rnd(sprites))
  else
    printh('no wall sprite')
  end
end
function floor_update_sprite(m, vec)
  if m == MAP.FLOOR_BASE then
    local sprites
    if rnd() < 0.8 then
      sprites = MAP.FLOOR_COMMON
    else
      sprites = MAP.FLOOR_UNCOMMON
    end
    LVL.set(vec, tbl_get_rnd(sprites))
  end
end

local function init_walls()
  local function is_wall(m, vec)
    if m ~= 0 then
      return false
    end
    for d in all(DIRS_8_ALL) do
      local v_dir = VEC.add(vec, d)
      if LVL.get(v_dir) == MAP.FLOOR_BASE then
        return true
      end
    end
    return false
  end
  local function wall_init(m, vec)
    if is_wall(m, vec) then
      LVL.set(vec, MAP.WALL_BASE)
    end
  end

  map_each(wall_init)
  map_each(wall_update_sprite)
  map_each(floor_update_sprite)
end

-- ===== init =====--
local function m_init(m, vec)
  if m == MAP.HERO then
    G.hero = HERO.create(VEC.cp(vec))
    mset(vec.x / 8, vec.y / 8, MAP.FLOOR_BASE)
  end
end
function LVL.init()
  -- map positions should include space for outer walls
  local LEVEL_1 = {
    vec_start = VEC.from(0, 0),
    vec_end = VEC.from(13, 13)
  }
  local LEVEL_2 = {}
  G.level = LEVEL_1
  map_each(m_init)
  init_walls()
end

-- ===== draw =====--
local function m_draw(m, vec)
  spr(m, vec.x, vec.y)
end
function LVL.draw()
  map_each(m_draw)
end

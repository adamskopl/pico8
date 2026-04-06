LVL = {}

--===== get/set =====--
function LVL.get(vec)
  return mget(vec.x / 8, vec.y / 8)
end

function LVL.set(vec, val)
  return mset(vec.x / 8, vec.y / 8, val)
end

--===== global utils =====--
function LVL.is_wall(vec)
  return MAP.WALL_ALL[LVL.get(vec)]
end

--===== local helpers ======--
local function map_each(cb)
  for x = G.level.vec_start.x, G.level.vec_end.x do
    for y = G.level.vec_start.y, G.level.vec_end.y do
      cb(mget(x, y), VEC.from(x * 8, y * 8))
    end
  end
end

local CNT = 0
local TARGET = 25
--===== walls =====--
local function wall_update_sprite(m, vec)
  CNT = CNT + 1
  -- if CNT == TARGET then add(DBG.WALLS1, vec) end
  if not LVL.is_wall(vec) then return end
  -- if CNT ~= TARGET then return end
  printh(CNT .. ' wall-upd' .. ' ' .. VEC.key(vec))
  local wall_neigh_cnt = 0
  local wall_neigh = {}
  for d in all(DIRS_8_ALL) do
    local v_dir = VEC.add(vec, d)
    if LVL.is_wall(v_dir) then
      wall_neigh_cnt = wall_neigh_cnt + 1
      wall_neigh[VEC.key(d)] = true
      printh('adding ' .. VEC.key(d))
      -- add(DBG.WALLS2, v_dir)
    end
  end
  local up = wall_neigh['0_-8']
  local right = wall_neigh['8_0']
  local down = wall_neigh['0_8']
  local left = wall_neigh['-8_0']

  -- corners
  if down and left then -- UR
    LVL.set(vec, 202)
  end
  if up and left then -- DR
    LVL.set(vec, 234)
  end
  if right and up then -- DL
    LVL.set(vec, 232)
  end
  if right and down then -- UL
    LVL.set(vec, 200)
  end
  -- left/right
  if up and down and not left and not right then
    LVL.set(vec, 216)
  end
  -- up/down
  if left and right and not up and not down then
    LVL.set(vec, 201)
  end
  printh('wall-upd END')
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
end

--===== init =====--
local function m_init(m, vec)
  if m == MAP.HERO then
    G.player = PLAYER.create(VEC.cp(vec))
    mset(vec.x / 8, vec.y / 8, MAP.FLOOR_BASE)
  end
end
function LVL.init()
  -- map positions should include space for outer walls
  local LEVEL_1 = {
    vec_start = VEC.from(0, 0), vec_end = VEC.from(6, 5)
  }
  local LEVEL_2 = {
  }
  G.level = LEVEL_1
  map_each(m_init)
  init_walls()
end

--===== draw =====--
local function m_draw(m, vec)
  spr(m, vec.x, vec.y)
end
function LVL.draw()
  map_each(m_draw)
  DBG.drawWalls1()
  DBG.drawWalls2()
end

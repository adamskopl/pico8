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

--===== walls =====--
local function wall_update_sprite(_, vec)
  if not LVL.is_wall(vec) then return end
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

  if neigh_cnt == 1 then
    if up then
      LVL.set(vec, MAP.WALL_UD[1])
    elseif down then
      LVL.set(vec, MAP.WALL_LR[1])
    end
  elseif neigh_cnt == 2 then
    -- corners
    if down and left then      -- UR
      LVL.set(vec, MAP.WALL_UR[1])
    elseif up and left then    -- DR
      LVL.set(vec, MAP.WALL_DR[1])
    elseif right and up then   -- DL
      LVL.set(vec, MAP.WALL_DL[1])
    elseif right and down then -- UL
      LVL.set(vec, MAP.WALL_UL[1])
    elseif up and down and not left and not right then
      LVL.set(vec, MAP.WALL_LR[1]) -- left/right
    elseif left and right and not up and not down then
      LVL.set(vec, MAP.WALL_UD[1]) -- up/down
    end
  elseif neigh_cnt == 3 then
    if down then
      LVL.set(vec, MAP.WALL_LR[1])
    elseif up then
      LVL.set(vec, MAP.WALL_UD[1])
    end
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
    vec_start = VEC.from(0, 0), vec_end = VEC.from(6, 4)
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

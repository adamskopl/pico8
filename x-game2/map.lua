MAP = {}

--===== get/set =====--
function MAP.get(vec)
  return mget(vec.x / 8, vec.y / 8)
end

function MAP.set(vec, val)
  return mset(vec.x / 8, vec.y / 8, val)
end

local function map_each(cb)
  for x = G.level.vec_start.x, G.level.vec_end.x do
    for y = G.level.vec_start.y, G.level.vec_end.y do
      cb(mget(x, y), VEC.from(x * 8, y * 8))
    end
  end
end

--===== walls =====--
local function is_wall(m, vec)
  if m ~= 0 then
    return false
  end
  for d in all(DIRS_8_ALL) do
    local v_dir = VEC.add(vec, d)
    if MAP.get(v_dir) == CFG.MAP.FLOOR then
      return true
    end
  end
  return false
end
local function wall_init(m, vec)
  if is_wall(m, vec) then
    MAP.set(vec, CFG.MAP.WALL)
  end
end
local function init_walls()
  map_each(wall_init)
end

--===== init =====--
local function m_init(m, vec)
  if m == CFG.MAP.HERO then
    G.player = PLAYER.create(VEC.cp(vec))
    mset(vec.x / 8, vec.y / 8, CFG.MAP.FLOOR)
  end
end
function MAP.init()
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
  if m == CFG.MAP.FLOOR then
    spr(CFG.MAP.FLOOR, vec.x, vec.y)
  elseif m == CFG.MAP.WALL then
    spr(CFG.MAP.WALL, vec.x, vec.y)
  end
end
function MAP.draw()
  map_each(m_draw)
end

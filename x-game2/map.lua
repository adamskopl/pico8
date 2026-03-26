MAP = {}

local function map_each(cb)
  for x = G.level.v_start.x, G.level.v_end.x do
    for y = G.level.v_start.y, G.level.v_end.y do
      cb(mget(x, y), VEC.from(x * 8, y * 8))
    end
  end
end

local function floor_surround_with_wall(v_floor)
  for dir8 in all(DIRS_8) do

  end
end
local function m_init(m, v)
  if m == CFG.MAP.HERO then
    G.player = PLAYER.create(VEC.cp(v))
    mset(v.x / 8, v.y / 8, CFG.MAP.FLOOR)
  end
end
function MAP.init()
  -- map positions should include space for outer walls
  local LEVEL_1 = {
    v_start = VEC.from(0, 0), v_end = VEC.from(6, 5)
  }
  local LEVEL_2 = {
  }
  G.level = LEVEL_1
  map_each(m_init)
end

local function m_draw(m, v)
  if m == CFG.MAP.FLOOR then
    spr(CFG.MAP.FLOOR, v.x, v.y)
  elseif m == CFG.MAP.WALL then
    spr(CFG.MAP.WALL, v.x, v.y)
  end
end
function MAP.draw()
  map_each(m_draw)
end

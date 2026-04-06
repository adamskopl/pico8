MAP = {
  HERO = 144,
  FLOOR_BASE = 66,
  FLOOR_COMMON = { 49, 50, 51, 64, 65, 68, 70, 81, 82, },
  FLOOR_UNCOMMON = { 48, 50, 67, 80, 83 },
  WALL_ALL = {}, -- set. filled later
  WALL_DBG = { 202, 234, 232, 200, 216, 201 },
  WALL_BASE = 241,
  WALL_UL = { 2, 10 },    -- up left
  WALL_UR = { 4, 8, 12 }, -- up right...
  WALL_DR = { 36, 40, 44 },
  WALL_DL = { 34, 38, 42 },
  WALL_LR = { 18, 20, 22, 26, 28 }, -- left/right
  WALL_UD = { 3, 11 }               -- up/down
}
printh(MAP.WALL_UR[0])
--===== init WALL_ALL =====--
MAP.WALL_ALL[MAP.WALL_BASE] = true
set_add_tbl(MAP.WALL_ALL, MAP.WALL_DBG)
set_add_tbl(MAP.WALL_ALL, MAP.WALL_UL)
set_add_tbl(MAP.WALL_ALL, MAP.WALL_UR)
set_add_tbl(MAP.WALL_ALL, MAP.WALL_DR)
set_add_tbl(MAP.WALL_ALL, MAP.WALL_DL)
set_add_tbl(MAP.WALL_ALL, MAP.WALL_LR)
set_add_tbl(MAP.WALL_ALL, MAP.WALL_UD)

COLORS = {
  BLACK = 0, DARK_BLUE = 1, DARK_PURPLE = 2, DARK_GREEN = 3, BROWN = 4, DARK_GRAY = 5, LIGHT_GRAY = 6, WHITE = 7, RED = 8, ORANGE = 9, YELLOW = 10, GREEN = 11, BLUE = 12, INDIGO = 13, PINK = 14, PEACH = 15
}

MAP = {
  HERO = 144,
  FLOOR_BASE = 66,
  WALL_ALL = {},          -- set. filled later
  WALL_BASE = 18,
  WALL_UL = { 2, 6, 10 }, -- up left
  WALL_UR = { 4, 8, 12 }, -- up right...
  WALL_DR = { 36, 40, 44 },
  WALL_DL = { 34, 38, 42 },
  WALL_LR = { 18, 20, 22, 24, 26, 28 }, -- left/right
  WALL_UD = { 3, 35, 7, 39, 11, 43 }    -- up/down
}
--===== init WALL_ALL =====--
MAP.WALL_ALL[MAP.WALL_BASE] = true
tbl_add_to_set(MAP.WALL_ALL, MAP.WALL_UL)
tbl_add_to_set(MAP.WALL_ALL, MAP.WALL_UR)
tbl_add_to_set(MAP.WALL_ALL, MAP.WALL_DR)
tbl_add_to_set(MAP.WALL_ALL, MAP.WALL_DL)
tbl_add_to_set(MAP.WALL_ALL, MAP.WALL_LR)
tbl_add_to_set(MAP.WALL_ALL, MAP.WALL_UD)

COLORS = {
  BLACK = 0, DARK_BLUE = 1, DARK_PURPLE = 2, DARK_GREEN = 3, BROWN = 4, DARK_GRAY = 5, LIGHT_GRAY = 6, WHITE = 7, RED = 8, ORANGE = 9, YELLOW = 10, GREEN = 11, BLUE = 12, INDIGO = 13, PINK = 14, PEACH = 15
}

LEVEL = {
  level = nil,
}
LEVEL_INTRO_DELAY = 0.5
level_index = nil
level_timer_button_start = nil
level_let_close_intro = false

LEVEL_1 = {
  pos = VEC.new(1, 1),
  hero = VEC.new(6, 8),
  coins = {
    { pos_m_trigger_tiles = { VEC.new(6, 8) }, pos_m = VEC.new(9, 8) },
    { pos_m_trigger_tiles = { VEC.new(4, 4), VEC.new(13, 13) }, pos_m = VEC.new(8, 9) },

    { pos_m_trigger_tiles = { VEC.new(9, 8) }, pos_m = VEC.new(11, 11) },
    -- corner coins
    { pos_m_trigger_tiles = { VEC.new(11, 11) }, pos_m = VEC.new(4, 4) },
    { pos_m_trigger_tiles = { VEC.new(11, 11) }, pos_m = VEC.new(13, 4) },
    { pos_m_trigger_tiles = { VEC.new(11, 11) }, pos_m = VEC.new(4, 13) },
    { pos_m_trigger_tiles = { VEC.new(11, 11) }, pos_m = VEC.new(13, 13) },
  },
  enemies = {
    -- { type = ENEMY_GRUNT, patrol = { from_m = VEC.new(8, 5), to_m = VEC.new(11, 5) } },
    -- { type = ENEMY_GRUNT, patrol = { from_m = VEC.new(8, 8), to_m = VEC.new(10, 8) } },
    -- { type = ENEMY_GRUNT, patrol = { from_m = VEC.new(8, 10), to_m = VEC.new(11, 10) } },
  },
}
LEVEL_2 = {
  pos = VEC.new(18, 1),
  hero = VEC.new(19, 2),
  coins = { { pos_m_trigger_tiles = { VEC.new(19, 2) }, pos_m = VEC.new(20, 3) } },
}
LEVEL_EMPTY = {
  title = "EMPTY",
  pos = VEC.new(1, 1),
  hero = VEC.new(19, 2),
  coins = { { pos_m_trigger_tiles = { VEC.new(19, 2) }, pos_m = VEC.new(20, 3) } },
  {},
}
LEVELS = { LEVEL_1, LEVEL_2, LEVEL_EMPTY }

function LEVEL.load_current()
  LEVEL.level = LEVELS[level_index]

  hero = HERO.new(pos_m_to_pos(LEVEL.level.hero))
  COINS.load(LEVEL.level)
  fireballs = {}
  mana_orbits = {}
  ENEMIES.load(LEVEL.level)
end

function LEVEL.load_next()
  level_timer_button_start = time()
  level_let_close_intro = false
  if level_index == nil then
    level_index = 1
  else
    level_index = level_index + 1
  end
  LEVEL.load_current()
end

function LEVEL.update_intro()
  if not level_let_close_intro and time() - level_timer_button_start > LEVEL_INTRO_DELAY then
    level_let_close_intro = true
    TEXT.start_blinking()
  end
  if level_let_close_intro then
    if any_pressed() then
      TEXT.stop_blinking()
      return true
    end
  end

  return false
end

function LEVEL.draw_level_intro()
  cls(COLORS.DARK_BLUE)
  TEXT.print_center(TEXT.get("LEVEL") .. " " .. level_index, COLORS.YELLOW)
  if level_let_close_intro then
    TEXT.draw_press_any()
  end
end

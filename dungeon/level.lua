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
  text_intro = TEXT.get("LEVEL1_INTRO"),
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
  hero = VEC.new(18, 16),
  -- text_intro = TEXT.get("LEVEL1_INTRO"),
  coins = {
    { pos_m_trigger_tiles = { VEC.new(18, 16) }, pos_m = VEC.new(20, 13) },
  },
  mana = {
    { pos_m = VEC.new(21, 16) },
  },
  enemies = {},
}
LEVELS = { LEVEL_2, LEVEL_1, LEVEL_2 }

function LEVEL.load_current()
  LEVEL.level = LEVELS[level_index]
  if not LEVEL.level then
    return
  end

  hero = HERO.new(pos_m_to_pos(LEVEL.level.hero))
  COINS.load(LEVEL.level)
  fireballs = {}
  mana_orbits = {}
  ENEMIES.load(LEVEL.level)
  level_load_mana()
end
function level_load_mana()
  if not LEVEL.level.mana then
    return
  end
  for m in all(LEVEL.level.mana) do
    printh("ad")
    MANA.add(pos_m_to_pos(m.pos_m), MANA_TYPE.COLLECT)
  end
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
  if not LEVEL.level then
    return false
  end

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
  if not LEVEL.level then
    TEXT.print_center("WORK IN PROGRESS", COLORS.YELLOW)
    return
  end

  TEXT.print_center(TEXT.get("LEVEL") .. " " .. level_index, COLORS.YELLOW)
  if level_let_close_intro then
    TEXT.draw_press_any()
  end
end

function LEVEL.on_level_start()
  if LEVEL.level.text_intro then
    TEXT.start_animated(LEVEL.level.text_intro)
  end
end

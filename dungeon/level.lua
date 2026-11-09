LEVEL = {
  index = nil,
  level = nil,
  levels = nil,

  timer_button_start = nil,
  let_close_intro = false,
}

LEVEL_1 = {
  title = "poziom 1. witaj",
  pos = VEC.new(1, 1),
  hero = VEC.new(4, 8),
  coins = {
    { pos_m_trigger_tile = VEC.new(4, 8), pos_m = VEC.new(12, 8) },
    { pos_m_trigger_tile = VEC.new(4, 8), pos_m = VEC.new(13, 8) },
    { pos_m_trigger_tile = VEC.new(5, 8), pos_m = VEC.new(14, 8) },
  },
  enemies = {
    -- { type = ENEMY_GRUNT, patrol = { from_m = VEC.new(8, 5), to_m = VEC.new(11, 5) } },
    -- { type = ENEMY_GRUNT, patrol = { from_m = VEC.new(8, 8), to_m = VEC.new(10, 8) } },
    -- { type = ENEMY_GRUNT, patrol = { from_m = VEC.new(8, 10), to_m = VEC.new(11, 10) } },
  },
}
LEVEL_2 = {
  title = "Level 2",
  pos = VEC.new(18, 1),
  hero = VEC.new(19, 2),
  coins = { { pos_m_trigger_tile = VEC.new(19, 2), pos_m = VEC.new(20, 3) } },
}
LEVEL_EMPTY = {
  title = "EMPTY",
  pos = VEC.new(1, 1),
  hero = VEC.new(19, 2),
  coins = { { pos_m_trigger_tile = VEC.new(19, 2), pos_m = VEC.new(20, 3) } },
}
LEVEL.levels = { LEVEL_1, LEVEL_2, LEVEL_EMPTY }

function LEVEL.load_next()
  printh("load level next")
  state = STATE.LEVEL_INTRO
  LEVEL.timer_button_start = time()
  LEVEL.let_close_intro = false
  if LEVEL.index == nil then
    LEVEL.index = 1
  else
    LEVEL.index = LEVEL.index + 1
  end

  LEVEL.level = LEVEL.levels[LEVEL.index]
  hero = HERO.new(pos_m_to_pos(LEVEL.level.hero))
  COINS.load(LEVEL.level)
  ENEMIES.load(LEVEL.level)
end

function LEVEL.update()
  if CONFIG.SKIP_INTRO then
    state = STATE.PLAYING
  end
  if not LEVEL.let_close_intro and time() - LEVEL.timer_button_start > 2 then
    LEVEL.let_close_intro = true
    TEXT.start_blinking()
  end
  if LEVEL.let_close_intro then
    if any_pressed() then
      TEXT.stop_blinking()
      state = STATE.PLAYING
    end
  end
end

function LEVEL.draw_level_intro()
  camera()
  cls(COLORS.DARK_BLUE)
  TEXT.print_center(TEXT.get("LEVEL") .. " " .. LEVEL.index, COLORS.YELLOW)
  if LEVEL.let_close_intro then
    local press_any = TEXT.get("PRESS_ANY")
    TEXT.draw_blinking(press_any, 128 - #press_any * 4 - 4, 128 - 10, COLORS.YELLOW)
  end
end

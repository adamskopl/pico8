--[
-- DICTIONARY
-- pos_* -> pixel pos like pixel 16,16
-- pos_m_* -> map pos like map 2,2
-- pos_mf_* -> map pos with fraction (ready for rounding)
--]
--
STATE = {
  LEVEL_INTRO = "LEVEL_INTRO",
  PLAYING = "PLAYING",
  GAME_OVER = "GAME_OVER",
}

function _init()
  printh("--init")

  dir_choice_t = nil
  dir_choice_delay = 0.1

  hero = nil
  coins = nil
  fireballs = nil
  mana_orbits = nil
  enemies = nil

  state = STATE.LEVEL_INTRO
  LEVEL.load_next()
end

function game_keys_update()
  if btnp(4) then
    HERO.on_O_press()
  end
  if btnp(5) then
    HERO.on_X_press()
  end

  local dir_choice = (btn(0) and VEC.new(-1, 0))
    or (btn(1) and VEC.new(1, 0))
    or (btn(2) and VEC.new(0, -1))
    or (btn(3) and VEC.new(0, 1))
    or nil

  if not dir_choice or MOV.moving(hero) then
    dir_choice_t = nil
    return
  end

  -- dir change
  if not hero.dir or not VEC.eq(dir_choice, hero.dir) then
    hero.dir = dir_choice
    dir_choice_t = time()
    return
  end

  -- same dir
  if not dir_choice_t or time() - dir_choice_t >= dir_choice_delay then
    if not wall_in_dir(hero) then
      sfx(SFX.WALK)
      MOV.start(hero)
    end
  end
end

function _update60()
  CAMERA.update()
  if state == STATE.LEVEL_INTRO then
    if CONFIG.SKIP_INTRO then
      state = STATE.PLAYING
    end
    if LEVEL.update_intro() then
      state = STATE.PLAYING
    end
  elseif state == STATE.PLAYING then
    game_keys_update()
    HERO.update()
    COINS.update()
    ENEMIES.update()
    FIREBALLS.update()
    MANA.update()
    check_win()
    check_game_over()
  elseif state == STATE.GAME_OVER then
    if GAME_OVER.update() then
      LEVEL.load_current()
      state = STATE.PLAYING
    end
  end
  -- always update:
  ANIM.update_singles()
  TEXT.update_blinking()
end

function _draw()
  if state == STATE.LEVEL_INTRO then
    LEVEL.draw_level_intro()
  elseif state == STATE.PLAYING then
    cls(COLORS.BLACK)
    CAMERA.apply(0, 0)
    map(LEVEL.level.pos.x, LEVEL.level.pos.y, 0, 0, 16, 16)

    camera()
    line(0, 0, 127, 0, 13)
    line(0, 0, 0, 127, 13)
    line(0, 127, 127, 127, 13)
    line(127, 0, 127, 127, 13)

    CAMERA.apply(LEVEL.level.pos.x * 8, LEVEL.level.pos.y * 8)
    COINS.draw()
    ENEMIES.draw()
    FIREBALLS.draw()
    HERO.draw()
    DEBUGGER.draw()
    ANIM.draw_singles()
    MANA.draw()
  elseif state == STATE.GAME_OVER then
    cls(COLORS.DARK_BLUE)
    CAMERA.apply(LEVEL.level.pos.x * 8, LEVEL.level.pos.y * 8)
    HERO.draw()
    COINS.draw()
    ANIM.draw_singles()
    TEXT.draw_press_any()
  end
end

function check_win()
  if #coins == 0 then
    -- LEVEL.load_next()
  end
end
function check_game_over()
  if #COINS.get_dead() > 0 then
    state = STATE.GAME_OVER
    GAME_OVER.start()
  end
end

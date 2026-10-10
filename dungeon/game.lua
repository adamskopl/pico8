--[
-- DICTIONARY
-- pos_* -> pixel pos like pixel 16,16
-- pos_m_* -> map pos like map 2,2
-- pos_mf_* -> map pos with fraction (ready for rounding)
--]
--
function _init()
  printh("--init")
  dir_choice_t = nil
  dir_choice_delay = 0.1

  G = {
    hero = nil,
    coins = nil,
  }
  STATE.change(STATE.LEVEL_INTRO)
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

  if not dir_choice or MOV.moving(G.hero) then
    dir_choice_t = nil
    return
  end

  -- dir change
  if not G.hero.dir or not VEC.eq(dir_choice, G.hero.dir) then
    G.hero.dir = dir_choice
    dir_choice_t = time()
    return
  end

  -- same dir
  if not dir_choice_t or time() - dir_choice_t >= dir_choice_delay then
    if not wall_in_dir(G.hero) then
      sfx(SFX.WALK)
      MOV.start(G.hero)
    end
  end
end

function _update60()
  if STATE.state == STATE.LEVEL_INTRO then
    LEVEL.update()
  elseif STATE.state == STATE.PLAYING then
    game_keys_update()
    HERO.update()
    COINS.update()

    if #G.coins == 0 then
      printh("FINISH")
      sfx(SFX.WIN)
      STATE.change(STATE.LEVEL_INTRO)
    end
    ANIM.update_singles()
  end
end

function _draw()
  if STATE.state == STATE.LEVEL_INTRO then
    LEVEL.draw_level_intro()
  elseif STATE.state == STATE.PLAYING then
    cls(0)
    camera()
    map(LEVEL.level.pos.x, LEVEL.level.pos.y, 0, 0, 16, 16)
    line(0, 0, 127, 0, 13)
    line(0, 0, 0, 127, 13)
    line(0, 127, 127, 127, 13)
    line(127, 0, 127, 127, 13)

    camera(LEVEL.level.pos.x * 8, LEVEL.level.pos.y * 8)
    COINS.draw()
    HERO.draw()
    DEBUGGER.draw()
    ANIM.draw_singles()
  end
end

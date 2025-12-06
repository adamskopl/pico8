function game_init()
  STATE_TITLE = "STATE_TITLE"
  STATE_PLAY_INTRO = "STATE_PLAY_INTRO"
  STATE_PLAY = "STATE_PLAY"
  STATE_OVER = "STATE_OVER"
  STATE_WIN = "STATE_WIN"

  game = {
    level_idx = 2,
    state = STATE_PLAY,
    win_t = nil, -- time of win
    eyes_num_start = 0,
    eyes_num = 0
  }
end

function game_level_loaded()
  game.eyes_num_start = #eyes
  game.eyes_num = #eyes
end

function game_update()

  -- PLAY:
  if game.state == STATE_PLAY then
    -- check if eye is killed (from the last time)
    -- if yes, display text
    if game.eyes_num ~= #eyes then
      game.eyes_num = #eyes
      if #eyes == 0 then -- WIN
        game.state = STATE_WIN
        game.win_t = t()
        text_start(LANG.LEVEL_CLEARED, 30, nil)
        -- TURN ON IN THE END

        -- music(0)
        flowers_start()
        clean_level()
      else
        local eyes_left = game.eyes_num_start - #eyes
        text = LANG.EYES_CLEARED(eyes_left,
          game.eyes_num_start)
        text_start(text, 23, 2)
      end
    end
  end

  -- WIN: check if player leaves screen, then go to next level
  if game.state == STATE_WIN then
    if p and
      (p.pos.x < 0 or p.pos.x > 127 or p.pos.y < 0 or
        p.pos.y > 127) then
      -- increment level index and wrap if needed
      game.level_idx = game.level_idx + 1
      if game.level_idx > #LEVELS then
        game.level_idx = 1
      end

      -- set state to play intro and reset play_intro timer
      game.state = STATE_PLAY_INTRO
      PLAY_INTRO.t_start = nil

      -- re-init level and related state
      init_lvl()
      game_level_loaded()
    end
  end
end

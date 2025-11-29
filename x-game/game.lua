function game_init()
  STATE_TITLE = "STATE_TITLE"
  STATE_PLAY_INTRO = "STATE_PLAY_INTRO"
  STATE_PLAY = "STATE_PLAY"
  STATE_OVER = "STATE_OVER"
  STATE_WIN = "STATE_WIN"

  game = {
    level = LEVELS[1],
    state = STATE_TITLE,
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

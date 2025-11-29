function game_init()
  STATE_INTRO = "STATE_INTRO"
  STATE_PLAY = "STATE_PLAY"
  STATE_OVER = "STATE_OVER"
  STATE_WIN = "STATE_WIN"

  game = {
    level = LEVELS[2],
    state = STATE_INTRO,
    -- over = false,
    -- win = false,
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

      -- TURN ON IN THE END

      -- music(0)
      text_start("LEVEL CLEARED!", 30, nil)
      flowers_start()
      clean_level()
    else
      local eyes_left = game.eyes_num_start - #eyes
      text = "EYES CLEARED: " .. tostr(eyes_left) .. "/" ..
               tostr(game.eyes_num_start)
      text_start(text, 23, 2)
    end
  end
end

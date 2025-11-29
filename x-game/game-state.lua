function init_game_state()
  game_state = {
    over = false,
    win = false,
    win_t = nil, -- time of win
    eyes_num_start = #eyes,
    eyes_num = #eyes
  }
end

function update_game_state()
  -- check if eye is killed (from the last time)
  -- if yes, display text
  if game_state.eyes_num ~= #eyes then
    game_state.eyes_num = #eyes
    if #eyes == 0 then -- WIN
      game_state.win = true
      game_state.win_t = t()
      music(0)
      text_start("LEVEL CLEARED!", 30, nil)
      flowers_start()
      clean_level()
    else
      local eyes_left = game_state.eyes_num_start - #eyes
      text = "EYES CLEARED: " .. tostr(eyes_left) .. "/" ..
               tostr(game_state.eyes_num_start)
      text_start(text, 23, 2)
    end
  end
end

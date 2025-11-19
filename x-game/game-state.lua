function init_game_state()
  game_state = {
    eyes_num_start = #eyes,
    eyes_num = #eyes
  }
end

function update_game_state()
  -- check if eye is killed (from the last time)
  -- if yes, display text
  if game_state.eyes_num ~= #eyes then
    game_state.eyes_num = #eyes
    text_start(game_state.eyes_num,
      game_state.eyes_num_start)
  end
end

STATE = {
  LEVEL_INTRO = "LEVEL_INTRO",
  PLAYING = "PLAYING",
  GAME_OVER = "GAME_OVER",
  state = nil,
}

function STATE.change(newState)
  printh("state " .. newState)
  STATE.state = newState

  if newState == STATE.LEVEL_INTRO then
    LEVEL.load_next()
  elseif STATE == STATE.PLAYING then
  elseif STATE == STATE.GAME_OVER then
  end
end

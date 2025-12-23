function game_init()
  GAME_STATE_TITLE = "STATE_TITLE"
  GAME_STATE_PLAY_INTRO = "STATE_PLAY_INTRO"
  GAME_STATE_PLAY = "STATE_PLAY"

  PLAYER_STATE_PLAYING = "PLAYING"
  PLAYER_STATE_WIN = "WIN"
  PLAYER_STATE_LOST = "LOST"

  game = {
    level_idx = 1,
    state = nil,
    win_t = nil, -- time of win
    lost_t = nil, -- time of lost
    eyes_num_start = 0,
    eyes_num = 0,
    player_state = null
  }
  game_state_change(GAME_STATE_PLAY)
end

function game_state_change(state)
  game.state = state
  printh("game state changed to: " .. state)

  if state == GAME_STATE_TITLE then
    title_init()
  elseif state == GAME_STATE_PLAY_INTRO then
    play_intro_init()
  elseif state == GAME_STATE_PLAY then
    player_state_change(PLAYER_STATE_PLAYING)
    init_lvl()
    game.eyes_num_start = #eyes
    game.eyes_num = #eyes
  end
end

function player_state_change(state)
  printh("player state changed to: " .. state)
  game.player_state = state
  if state == PLAYER_STATE_LOST then
    game.lost_t = t()
  end
end

function game_update()
  if game.player_state == PLAYER_STATE_PLAYING then
    -- check if eye is killed (from the last time)
    -- if yes, display text
    if game.eyes_num ~= #eyes then
      game.eyes_num = #eyes
      if #eyes == 0 then -- WIN
        player_state_change(PLAYER_STATE_WIN)
        game.win_t = t()
        text_start(LANG.LEVEL_CLEARED, 30, nil)
        music(0)
        flowers_start()
        clean_level()
      else
        local eyes_left = game.eyes_num_start - #eyes
        text = LANG.EYES_CLEARED(eyes_left,
          game.eyes_num_start)
        text_start(text, 23, 2)
      end
    end
    -- WIN: check if player leaves screen, then go to next level
  elseif game.player_state == PLAYER_STATE_WIN then
    if p and
      (p.pos.x < 0 or p.pos.x > 127 or p.pos.y < 0 or
        p.pos.y > 127) then
      -- increment level index and wrap if needed
      game.level_idx = game.level_idx + 1
      if game.level_idx > #LEVELS then
        game.level_idx = 1
      end
    end
  elseif game.player_state == PLAYER_STATE_LOST then
    if t() - game.lost_t >= 3 then
      game_state_change(GAME_STATE_PLAY_INTRO)
      game.lost_t = nil
    end
  end
end

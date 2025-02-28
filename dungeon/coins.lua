COINS = {
  TYPES = {
    TILE_TRIGGERED = "TILE_TRIGGERED",
    INSTANT = "INSTANT",
  },
}
COINS_TIME = {
  BLINK = 1,
  BLINK_LAST = 1,
  DISAPPEAR = 1,
}
COINS_STATE = {
  NORMAL = "NORMAL",
  BLINKING = "BLINKING",
  BLINKING_DEATH = "BLINKING_DEATH",
}

function COINS.new(config)
  local c = ENTITY.new(pos_m_to_pos(config.pos_m))
  c.coin_type = config.coin_type
  c.coin_state = COINS_STATE.NORMAL
  c.arrival_time = nil
  if c.coin_type == COINS.TYPES.TILE_TRIGGERED then
    c.visible = false
    c.pos_m_trigger_tile = config.pos_m_trigger_tile
  elseif c.coin_type == COINS.TYPES.INSTANT then
    c.arrival_time = time()
  end

  ANIM.apply_loop(c, GFX.COIN, GFX.COIN, GFX.COIN + 3, 0.12)
  ANIM.start(c)
  return c
end

function COINS.load(level)
  coins = {}
  for config in all(level.coins) do
    local c = COINS.new(config)
    add(coins, c)
  end
end

function COINS.update()
  local now = time()
  for c in all(coins) do
    if
      not c.visible
      and c.coin_type == COINS.TYPES.TILE_TRIGGERED
      and TILES.collide(hero.pos, pos_m_to_pos(c.pos_m_trigger_tile))
    then
      c.visible = true
      c.arrival_time = now
      EFFECTS.create_arrival(c.pos)
    end
    coins_update_blinking(c, now)
    ANIM.update(c)
    EFFECTS.update(c)
  end
end
function coins_update_blinking(c, now)
  if not c.arrival_time then
    return
  end

  local time_diff = now - c.arrival_time
  if c.coin_state == COINS_STATE.NORMAL and time_diff >= COINS_TIME.BLINK then
    EFFECTS.apply_blinking(c, EFFECTS.BLINK_FREQ_LOW)
    c.coin_state = COINS_STATE.BLINKING
  elseif c.coin_state == COINS_STATE.BLINKING and time_diff >= COINS_TIME.BLINK + COINS_TIME.BLINK_LAST then
    EFFECTS.apply_blinking(c, EFFECTS.BLINK_FREQ_HIGH)
    c.coin_state = COINS_STATE.BLINKING_DEATH
  elseif
    c.coin_state == COINS_STATE.BLINKING_DEATH
    and time_diff >= COINS_TIME.BLINK + COINS_TIME.BLINK_LAST + COINS_TIME.DISAPPEAR
  then
    STATE.change(STATE.GAME_OVER)
  end
end

function COINS.draw()
  for c in all(coins) do
    ANIM.draw(c)
  end
end

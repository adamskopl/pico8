COINS = {}
COINS_TIME = {
  BLINK = 3,
  BLINK_LAST = 2,
  DISAPPEAR = 2,
}
COINS_STATE = {
  NORMAL = "NORMAL",
  BLINKING = "BLINKING",
  BLINKING_DEATH = "BLINKING_DEATH",
}

function COINS.new(config)
  local c = ENTITY.new(pos_m_to_pos(config.pos_m))
  c.coin_state = COINS_STATE.NORMAL
  c.arrival_time = nil
  c.visible = false
  c.pos_m_trigger_tiles = config.pos_m_trigger_tiles

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
    if not c.visible and coin_is_on_trigger_tile(c) then
      c.visible = true
      c.arrival_time = now
      EFFECTS.create_arrival(c.pos)
    end

    if c.arrival_time then
      coin_update_blinking(c)
    end

    ANIM.update(c)
    EFFECTS.update(c)
  end
end
function coin_is_on_trigger_tile(c)
  for pos_m in all(c.pos_m_trigger_tiles) do
    if TILES.collide(hero.pos, pos_m_to_pos(pos_m)) then
      return true
    end
  end
  return false
end
function coin_update_blinking(c)
  local time_diff = time() - c.arrival_time
  if c.coin_state == COINS_STATE.NORMAL and time_diff >= COINS_TIME.BLINK then
    EFFECTS.apply_blinking(c, EFFECTS.BLINK_FREQ_LOW)
    c.coin_state = COINS_STATE.BLINKING
  elseif c.coin_state == COINS_STATE.BLINKING and time_diff >= COINS_TIME.BLINK + COINS_TIME.BLINK_LAST then
    EFFECTS.apply_blinking(c, EFFECTS.BLINK_FREQ_HIGH)
    c.coin_state = COINS_STATE.BLINKING_DEATH
  end
end

function COINS.draw()
  for c in all(coins) do
    ANIM.draw(c)
    if level_index == 1 and c.visible and c.arrival_time then
      local now_t = time()
      local time_left =
        max(0, COINS_TIME.BLINK + COINS_TIME.BLINK_LAST + COINS_TIME.DISAPPEAR - (now_t - c.arrival_time))
      local color = COLORS.YELLOW
      if c.blinking and c.blinking.apply_red then
        color = COLORS.RED
      end
      print(ceil(time_left), c.pos.x + 2, c.pos.y - 5, color)
    end
  end
end

function COINS.get_dead()
  dead = {}
  for c in all(coins) do
    if coin_is_dead(c) then
      add(dead, c)
    end
  end
  return dead
end
function COINS.leave_dead()
  for i = #coins, 1, -1 do
    local c = coins[i]
    if not coin_is_dead(c) then
      deli(coins, i)
    end
  end
end
function coin_is_dead(c)
  if not c.arrival_time then
    return
  end
  local time_diff = time() - c.arrival_time
  return c.coin_state == COINS_STATE.BLINKING_DEATH
    and time_diff >= COINS_TIME.BLINK + COINS_TIME.BLINK_LAST + COINS_TIME.DISAPPEAR
end

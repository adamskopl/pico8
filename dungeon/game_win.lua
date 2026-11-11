GAME_WIN = {}
GW_TIMES = {
  CHEST_DELAY = 1,
  COIN_START_DELAY = 1 + 1,
  OBJECTS_DISAPPEAR = 1,
  WIN_END_DELAY = 1,
}
GW_COIN_SPEED = 1.5

function GAME_WIN.start()
  gw_started_t = time()
  gw_chest_pos = nil
  gw_chest_appear_t = nil
  gw_last_coin_collect_t = nil
  gw_objects_disappear_t = nil
  gw_coins_remaining = #LEVEL.level.coins
  gw_coin = nil
end

function GAME_WIN.update()
  MOV.update(hero)
  ANIM.update(hero)

  if not gw_chest_pos and time() - gw_started_t >= GW_TIMES.CHEST_DELAY then
    gw_chest_pos = VEC.sub(hero.pos, VEC.multi(hero.dir, 9))
    hero.dir = VEC.multi(hero.dir, -1)
    EFFECTS.create_arrival(VEC.cp(gw_chest_pos))
  end

  if not gw_coin_pos and time() - gw_started_t >= GW_TIMES.COIN_START_DELAY and gw_coins_remaining > 0 then
    gw_coin_pos = VEC.new(gw_chest_pos.x, gw_chest_pos.y - 16)
  end

  if gw_coin_pos then
    gw_update_coin()
  end

  -- new
  if gw_last_coin_collect_t then
    delta_t = time() - gw_last_coin_collect_t
    if chest_pos and delta_t >= GW_TIMES.OBJECTS_DISAPPEAR then
      EFFECTS.create_disappear(VEC.cp(chest_pos))
      EFFECTS.create_disappear(VEC.cp(hero.pos))
      chest_pos = nil
    end
    if not chest_pos and delta_t >= GW_TIMES.OBJECTS_DISAPPEAR + GW_TIMES.WIN_END_DELAY then
      return true
    end
  end

  return false
end
function gw_update_coin()
  if gw_coin_pos.y + GW_COIN_SPEED >= gw_chest_pos.y then
    gw_coin_pos = nil
    sfx(SFX.COIN)
    gw_coins_remaining = gw_coins_remaining - 1
    if gw_coins_remaining == 0 then
      gw_last_coin_collect_t = time()
    end
    return
  end

  gw_coin_pos.y = gw_coin_pos.y + GW_COIN_SPEED
end

function GAME_WIN.draw()
  cls(COLORS.DARK_BLUE)
  CAMERA.apply(LEVEL.level.pos.x * 8, LEVEL.level.pos.y * 8)
  if not gw_objects_disappear_t then
    HERO.draw()
  end
  if gw_chest_pos then
    spr(GFX.CHEST, gw_chest_pos.x, gw_chest_pos.y)
  end
  if gw_coin then
    spr(GFX.COIN, gw_coin_pos.x, gw_coin_pos.y)
  end
  ANIM.draw_singles()
end

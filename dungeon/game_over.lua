GAME_OVER = {}
GO_KEEP_COINS = 0.5
GO_START_CRYING = 1
go_start_time = nil
go_coins_gone = false
go_cry_time = nil
go_crying = false

function GAME_OVER.start()
  go_start_time = time()
  go_coins_gone = false
  go_cry_time = nil
  go_crying = false

  COINS.leave_dead()
  ANIM.apply_loop(hero, GFX.HERO_CRY, GFX.HERO_CRY, GFX.HERO_CRY + 1, 0.4)
end
function GAME_OVER.update()
  if not go_coins_gone then
    if time() - go_start_time < GO_KEEP_COINS then
      COINS.update()
    else
      go_coins_gone = true
      for c in all(coins) do
        EFFECTS.create_disappear(c.pos)
      end
      coins = {}
    end
  end

  if not go_crying then
    if time() - go_start_time < GO_START_CRYING then
      return false
    end
    go_crying = true
    ANIM.start(hero)
    go_cry_time = time() - 0.4
    TEXT.start_blinking()
  end

  ANIM.update(hero)
  if time() - go_cry_time >= 0.8 then
    go_cry_time = time()
    sfx(SFX.CRY)
  end
  if any_pressed() then
    TEXT.stop_blinking()
    return true
  end
  return false
end

function GAME_OVER.draw()
  cls(COLORS.DARK_BLUE)
  CAMERA.apply(LEVEL.level.pos.x * 8, LEVEL.level.pos.y * 8)
  HERO.draw()
  COINS.draw()
  ANIM.draw_singles()
  TEXT.draw_press_any()
end

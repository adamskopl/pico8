GAME_OVER = {}
GO_TIMES = {
  KEEP_COINS = 2,
}
go_start_time = nil
go_coins_gone = false
go_cry_time = nil
go_crying = false

function GAME_OVER.start()
  state = STATE.GAME_OVER
  go_start_time = time()
  go_coins_gone = false
  go_cry_time = nil
  go_crying = false

  COINS.leave_dead()
  ANIM.apply_loop(hero, GFX.HERO_CRY, GFX.HERO_CRY, GFX.HERO_CRY + 1, 0.4)
end
function GAME_OVER.update()
  if not go_coins_gone then
    if time() - go_start_time >= GO_TIMES.KEEP_COINS then
      go_coins_gone = true
      for c in all(coins) do
        EFFECTS.create_disappear(c.pos)
      end
      coins = {}
    else
      COINS.update()
    end
  end

  if not go_crying then
    if time() - go_start_time >= 3 then
      go_crying = true
      ANIM.start(hero)
      go_cry_time = time() - 0.4
    end
  else
    ANIM.update(hero)
    if time() - go_cry_time >= 0.8 then
      go_cry_time = time()
      sfx(SFX.CRY)
    end
  end
end

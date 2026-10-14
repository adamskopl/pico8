COINS = {}
function COINS.new(pos)
  local c = ENTITY.new(pos)
  local gfx_coin = flr(rnd(2)) == 0 and GFX.COIN or GFX.COIN2
  ANIM.apply_loop(c, gfx_coin, gfx_coin, gfx_coin + 3, 0.12)
  ANIM.start(c)
  return c
end
function COINS.load(level)
  coins = {}
  for c_pos in all(level.coins) do
    local c = COINS.new(VEC.multi(c_pos, 8))
    add(coins, c)
  end
end
function COINS.update()
  for c in all(coins) do
    ANIM.update(c)
  end
end
function COINS.draw()
  for c in all(coins) do
    ANIM.draw(c)
  end
end

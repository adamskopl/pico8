COINS = {}
function COINS.new(pos)
  local c = ENTITY.new(pos)
  ANIM.apply_loop(c, GFX.COIN, GFX.COIN, GFX.COIN + 3, 0.1)
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

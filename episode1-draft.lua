function _init()
  player = {
    x = 128 / 2 - 8,
    y = 128 - 16,
    speed = 2
  }
  anvils = {}
end

function _update()
  -- player movement
  if btn(0) then
    player.x = max(0, player.x - player.speed)
  elseif btn(1) then
    player.x = min(128 - 16, player.x + player.speed)
  end

  -- spawn anvils
  if (#anvils < 5 and rnd(100) < 2) then
    add(anvils, {
      x = rnd(120),
      y = 0
    })
  end

  -- move anvils
  for anvil in all(anvils) do
    anvil.y = anvil.y + 2
    if (anvil.y > 128) then
      del(anvils, anvil)
    end
  end
end

function _draw()
  cls(12)
  spr(1, player.x, player.y, 2, 2)
  for anvil in all(anvils) do
    spr(0, anvil.x, anvil.y, 1, 1)
  end
end

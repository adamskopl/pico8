function _init()
  player = {
    x = 128 / 2 - 8,
    y = 128 - 16,
    speed = 2,
    frame = 1,
    anim_dt = 0
  }
  anvils = {}
end

function _update()
  -- player movement
  if btn(0) then
    player.x = max(0, player.x - player.speed)
    animate_player()
  elseif btn(1) then
    player.x = min(128 - 16, player.x + player.speed)
    animate_player()
  else
    player.frame = 1
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
  spr(player.frame, player.x, player.y, 2, 2)
  for anvil in all(anvils) do
    spr(0, anvil.x, anvil.y, 1, 1)
  end
end

function animate_player()
  player.anim_dt = player.anim_dt + 1
  if (player.anim_dt % 2 == 0) then
    player.frame = player.frame + 2
    if (player.frame == 7) then
      player.frame = 1
    end
  end
end

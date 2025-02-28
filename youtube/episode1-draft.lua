function _init()
  player = {
    x = 128 / 2 - 8,
    y = 128 - 16,
    w = 14,
    h = 13,
    speed = 2,
    frame = 1,
    anim_dt = 0,
    flip = false
  }
  anvils = {}
  anvils_speed = 1
  anvils_num = 5
  anvils_chance = 5
  score = 0
  game_over = false
end

function _update()
  if game_over then
    return
  end

  -- player movement
  if btn(0) then
    player.x = max(0, player.x - player.speed)
    player.flip = true
    animate_player()
  elseif btn(1) then
    player.x = min(128 - 16, player.x + player.speed)
    player.flip = false
    animate_player()
  else
    player.frame = 1
  end

  -- spawn anvils
  if t() % 5 == 0 then
    anvils_speed = anvils_speed + 0.3
    anvils_num = anvils_num + 1
    anvils_chance = anvils_chance + 1
  end
  if (#anvils < anvils_num and rnd(100) < anvils_chance) then
    add(anvils, {
      x = rnd(120),
      y = 0,
      w = 8,
      h = 5
    })
    score = score + 1
  end

  -- move anvils
  for anvil in all(anvils) do
    anvil.y = anvil.y + anvils_speed
    if (anvil.y > 128) then
      del(anvils, anvil)
    end

    -- collision
    if (check_collision(player, anvil)) then
      sfx(0)
      game_over = true
    end
  end
end

function _draw()
  if not game_over then
    cls(12)
    spr(player.frame, player.x, player.y, 2, 2, player.flip)
    for anvil in all(anvils) do
      spr(0, anvil.x, anvil.y, 1, 1)
    end
    print("score: " .. score, 5, 5, 8)
  else
    cls()
    print("GAME OVER", 128 / 2 - 15, 128 / 2, 8)
    print("SCORE: " .. score, 128 / 2 - 15, 128 / 2 + 10, 8)
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

function check_collision(a, b)
  return (a.x < b.x + b.w) and (a.x + a.w > b.x) and (a.y < b.y + b.h) and (a.y + a.h > b.y)
end

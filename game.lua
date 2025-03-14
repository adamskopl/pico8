player = {
  x = 128 / 2 - 8,
  y = 128 - 16,
  w = 13,
  h = 14,
  speed = 2,
  frame = 1,
  anim_timer = 0
}

-- falling objects (anvils)
objects = {}
fin = false

function _init()
  -- preload spritesheet (if needed)
end

function _update()
  -- player movement + animation
  if (btn(0)) then
    player.x = max(0, player.x - player.speed)
    animate_player()
  elseif (btn(1)) then
    player.x = min(112, player.x + player.speed)
    animate_player()
  else
    player.anim_timer = 0 -- reset animation when idle
  end

  -- spawn anvils randomly
  if (#objects < 5 and rnd(100) < 10) then
    add(objects, {
      x = rnd(120),
      y = 0,
      w = 8,
      h = 8,
      speed = 1 + rnd(2)
    })
  end

  -- move anvils
  for obj in all(objects) do
    obj.y = obj.y + obj.speed
    if (obj.y > 128) then
      del(objects, obj)
    end

    -- collision detection
    if (check_collision(player, obj)) then
      sfx(0) -- play collision sound
      _init() -- restart the game
      fin = true
    end
  end
end

function _draw()
  cls(12)

  -- draw player with animation
  spr(player.frame, player.x, player.y, 2, 2) -- 16x16 sprite
  -- rect(player.x, player.y, player.x + player.w - 1, player.y + player.h - 1, 8)

  -- draw anvils
  for obj in all(objects) do
    spr(0, obj.x, obj.y, 1, 1) -- 8x8 anvil sprite
  end
end

-- animate blacksmith by cycling through frames 1, 3, 5
function animate_player()
  player.anim_timer = player.anim_timer + 1
  if (player.anim_timer % 2 == 0) then
    player.frame = (player.frame == 1) and 3 or (player.frame == 3) and 5 or 1
  end
end

function check_collision(a, b)
  return a.x < b.x + b.w and a.x + a.w > b.x and a.y < b.y + b.h and a.y + a.h > b.y
end

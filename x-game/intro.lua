INTRO = {
  -- offset_y = 128
  offset_y = 128
}

function text_x_pos(t)
  return 64 - (#t * 2)
end

function text_y_pos(target_y)
  return target_y + INTRO.offset_y
end

function intro_update()
  if INTRO.offset_y > 0 then
    INTRO.offset_y = INTRO.offset_y - 0.5
    if INTRO.offset_y <= 0 then
      sfx(4)
    end
    return
  end

  -- after offset_y reaches 0, check for any key press
  if INTRO.offset_y <= 0 and any_key_pressed() then
    game.state = STATE_PLAY
  end
end

function draw_press_key()
  if (flr(time() * 2) % 2 == 0) then
    local msg = LANG.PRESS_KEY
    local x = 128 - (#msg * 4) - 2
    local y = 128 - 10
    print(msg, x, y, 7)
  end
end

function intro_draw()
  cls(COL.GROUND_WIN)
  print(LANG.AUTHOR, text_x_pos(LANG.AUTHOR),
    text_y_pos(8 * 1), 9)
  print(LANG.PRESENTS, text_x_pos(LANG.PRESENTS),
    text_y_pos(8 * 2), 7)
  print(LANG.TITLE, text_x_pos(LANG.TITLE),
    text_y_pos(8 * 4), 8)

  if INTRO.offset_y <= 0 then
    -- hero
    spr(96, 32, 64, 1, 1)
    spr(115, 33, 66, 1, 1)

    -- sprinkle flowers (sprites 16-19) around hero and enemy
    local flower_sprites = {16, 17, 18, 19}
    -- positions near hero
    spr(flower_sprites[1], 24, 72, 1, 1)
    spr(flower_sprites[2], 40, 80, 1, 1)
    spr(flower_sprites[3], 28, 88, 1, 1)
    spr(flower_sprites[4], 44, 70, 1, 1)
    -- above hero
    spr(flower_sprites[2], 32, 54, 1, 1)
    spr(flower_sprites[3], 40, 58, 1, 1)

    -- positions near enemy
    spr(flower_sprites[2], 80, 80, 1, 1)
    spr(flower_sprites[3], 104, 72, 1, 1)
    spr(flower_sprites[1], 96, 88, 1, 1)
    spr(flower_sprites[4], 112, 70, 1, 1)
    -- above enemy
    spr(flower_sprites[1], 88, 54, 1, 1)
    spr(flower_sprites[4], 96, 58, 1, 1)

    -- enemy (animated)
    local enemy_frame = 69 + (flr(time() / 0.1) % 2)
    spr(enemy_frame, 88, 64, 1, 1)

    draw_press_key()
  end
end

function any_key_pressed()
  for i = 4, 5 do
    if btnp(i) then
      return true
    end
  end
  return false
end

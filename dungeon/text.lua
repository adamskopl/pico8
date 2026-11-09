TEXT = {
  timer = nil,
  blink_draw = false,
  PL = {
    LEVEL = "poziom",
    PRESS_ANY = "naciskaj guzika...",
  },
  EN = {
    LEVEL = "level",
    PRESS_ANY = "press any...",
  },
}

function TEXT.get(key)
  return TEXT[CONFIG.LANG][key]
end

function TEXT.print_center(text, color)
  print(text, 128 / 2 - #text * 2, 128 / 2 - 10, color)
end

function TEXT.start_blinking()
  TEXT.blink_draw = true
  TEXT.timer = time()
end

function TEXT.stop_blinking()
  TEXT.blink_draw = false
  TEXT.timer = nil
end

function TEXT.update_blinking()
  if not TEXT.timer then
    return
  end
  if time() - TEXT.timer > 0.8 then
    TEXT.timer = time()
    TEXT.blink_draw = not TEXT.blink_draw
  end
end

function TEXT.draw_blinking(text, x, y, col)
  if TEXT.blink_draw then
    print(text, x, y, col)
  end
end

TEXT = {
  PL = {
    LEVEL = "poziom",
    PRESS_ANY = "naciskaj guzika...",
  },
  EN = {
    LEVEL = "level",
    PRESS_ANY = "press any...",
  },
}
text_timer = nil
text_blink_draw = false

function TEXT.get(key)
  return TEXT[CONFIG.LANG][key]
end

function TEXT.print_center(text, color)
  camera()
  print(text, 128 / 2 - #text * 2, 128 / 2 - 10, color)
end

function TEXT.start_blinking()
  text_blink_draw = true
  text_timer = time()
end

function TEXT.stop_blinking()
  text_blink_draw = false
  text_timer = nil
end

function TEXT.update_blinking()
  if not text_timer then
    return
  end
  if time() - text_timer > 0.8 then
    text_timer = time()
    text_blink_draw = not text_blink_draw
  end
end

function TEXT.draw_press_any()
  local press_any = TEXT.get("PRESS_ANY")
  text_draw_blinking(press_any, 128 - #press_any * 4 - 4, 128 - 10, COLORS.YELLOW)
end
function text_draw_blinking(text, x, y, col)
  camera()
  if text_blink_draw then
    print(text, x, y, col)
  end
end

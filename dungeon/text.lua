--[
--🅾️❎
--]

TEXT = {}
TEXT_LANGUAGES = {
  PL = {
    LEVEL = "poziom",
    PRESS_ANY = "naciskaj guzika...",
    LEVEL1_INTRO = "zbierz nim znikna!",
  },
  EN = {
    LEVEL = "level",
    PRESS_ANY = "press any...",
    LEVEL1_INTRO = "collect before they vanish!",
  },
}
text_timer_t = nil
text_blink_draw = false
text_animated = nil
text_animated_t = nil
text_animated_duration = 5
text_animated_x = 0
TEXT_ANIMATED_COLORS = { COLORS.BLUE, COLORS.WHITE, COLORS.YELLOW }

function TEXT.get(key)
  return TEXT_LANGUAGES[CONFIG.LANG][key]
end

function TEXT.print_center(text, color)
  camera()
  print(text, 128 / 2 - #text * 2, 128 / 2 - 10, color)
end

function TEXT.start_blinking()
  text_blink_draw = true
  text_timer_t = time()
end

function TEXT.stop_blinking()
  text_blink_draw = false
  text_timer_t = nil
end

function TEXT.update_blinking()
  if not text_timer_t then
    return
  end
  if time() - text_timer_t > 0.8 then
    text_timer_t = time()
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

function TEXT.start_animated(text_to_start, x, duration)
  text_animated = text_to_start
  text_animated_t = time()
  text_animated_x = x or 128 / 2 - #text_to_start * 2
  text_animated_duration = duration or text_animated_duration
end

function TEXT.update_animated()
  if text_animated_t and time() - text_animated_t >= text_animated_duration then
    text_animated = nil
  end
end

function TEXT.draw_animated()
  if not text_animated then
    return
  end
  text_draw_animated_string(text_animated, text_animated_x, 5)
end
function text_draw_animated_string(text, x0, y0)
  camera()
  rectfill(1, 1, 126, 6, COLORS.BLACK)
  local amplitude = 1
  x0 = x0 or 0
  y0 = y0 or 0
  for i = 1, #text do
    local t1_t = time() * 80 + i * 6
    local x = x0 + i * 4
    local y = y0 + sin(t1_t / 30) * amplitude
    local ch = sub(text, i, i)
    local color_index = 1 + flr((sin(t1_t / 20) + 1) * 1.499)
    local col = TEXT_ANIMATED_COLORS[color_index]
    print(ch, x, y, col)
  end
end

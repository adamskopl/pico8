--[
--🅾️❎
--]

TEXT = {}
text_languages = {
  PL = {
    LEVEL = "poziom",
    PRESS_ANY = "naciskaj guzika...",
    LEVEL1_INTRO = "zbierz nim znikna!",
    LEVEL2_INTRO = "lewel dwa",
  },
  EN = {
    LEVEL = "level",
    PRESS_ANY = "press any...",
    LEVEL1_INTRO = "collect before they vanish!",
    LEVEL2_INTRO = "lvlv 2",
  },
}
text_timer_t = nil
text_blink_draw = false
text_animated = nil
text_animated_t = nil
TEXT_ANIMATED_DURATION = 5
text_animated_x = 0
text_animated_icon = nil
text_animated_colors = { COLORS.BLUE, COLORS.WHITE, COLORS.YELLOW }

function TEXT.get(key)
  return text_languages[CONFIG.LANG][key]
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
  local now_t = time()
  if now_t - text_timer_t > 0.8 then
    text_timer_t = now_t
    text_blink_draw = not text_blink_draw
  end
end

function TEXT.draw_press_any()
  local press_any = TEXT.get("PRESS_ANY")
  text_draw_blinking(press_any, 124 - #press_any * 4, 118, COLORS.YELLOW)
end

function text_draw_blinking(text, x, y, col)
  camera()
  if text_blink_draw then
    print(text, x, y, col)
  end
end

function TEXT.start_animated(text_to_start, icon_gfx)
  text_animated = text_to_start
  text_animated_t = time()
  text_animated_icon = icon_gfx
  if icon_gfx then
    text_animated_x = 64 - #text_to_start * 2 + 2
  else
    text_animated_x = 128 / 2 - #text_to_start * 2
  end
end

function TEXT.update_animated()
  if text_animated_t and time() - text_animated_t >= TEXT_ANIMATED_DURATION then
    text_animated = nil
    text_animated_t = nil
    text_animated_icon = nil
  end
end

function TEXT.draw_animated()
  if not text_animated then
    return
  end
  camera()
  local now_t = time()
  if text_animated_icon then
    local icon_t = now_t * 80
    local icon_y = 5 + sin(icon_t / 30) * 1
    local icon_frame = text_animated_icon + flr(now_t / 0.12) % 4
    spr(icon_frame, text_animated_x - 6, icon_y - 2)
  end
  text_draw_animated_string(text_animated, text_animated_x, 5, now_t)
end

function text_draw_animated_string(text, x0, y0, now_t)
  camera()
  for i = 1, #text do
    local t1_t = now_t * 80 + i * 6
    local x = x0 + i * 4
    local y = y0 + sin(t1_t / 30)
    local ch = sub(text, i, i)
    local color_index = 1 + flr((sin(t1_t / 20) + 1) * 1.499)
    local col = text_animated_colors[color_index]
    print(ch, x, y, col)
  end
end

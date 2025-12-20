function play_intro_init()
  PLAY_INTRO = {
    t_start = t()
  }
end

-- Helper: splits text into lines that fit max_width (in chars)
function split_text_lines(text, max_width)
  local lines = {}
  local line = ""
  for word in all(split(text, " ")) do
    if #line > 0 then
      if #line + #word + 1 <= max_width then
        line = line .. " " .. word
      else
        add(lines, line)
        line = word
      end
    else
      line = word
    end
  end
  if #line > 0 then
    add(lines, line)
  end
  return lines
end

function play_intro_update()
  local elapsed = t() - PLAY_INTRO.t_start

  -- After 3s, allow key press to start level
  if elapsed >= 3 and any_key_pressed() then
    game_state_change(GAME_STATE_PLAY)
  end
end

function play_intro_draw()
  cls(0)
  local elapsed = t() - PLAY_INTRO.t_start

  if elapsed >= 1 then
    -- LEVEL X (white), centered above title
    local level_str = LANG.LEVEL_NUM(game.level_idx)
    local level_x = 64 - (#level_str * 2)
    local level_y = 28
    print(level_str, level_x, level_y, 7)

    -- Centered level title (red), in quotes
    local level = LEVELS[game.level_idx]
    local title = level.title[LANG == LANGS.pl and "pl" or
                    "en"]
    local quoted_title = '"' .. title .. '"'
    local text = level.text[LANG == LANGS.pl and "pl" or
                   "en"]
    local tx = 64 - (#quoted_title * 2)
    local ty = 40
    print(quoted_title, tx, ty, 8)

    -- Split text into lines if too long
    local max_chars = 28 -- fits 112px (28*4), adjust if needed
    local lines = split_text_lines(text, max_chars)
    for i, line in ipairs(lines) do
      local textx = 64 - (#line * 2)
      print(line, textx, ty + 12 + (i - 1) * 8, 7)
    end
  end

  if elapsed >= 3 then
    -- Blinking "PRESS KEY"
    if flr(time() * 2) % 2 == 0 then
      local msg = LANG.PRESS_KEY
      local x = 128 - (#msg * 4) - 2
      local y = 128 - 10
      print(msg, x, y, 7)
    end
  end
end

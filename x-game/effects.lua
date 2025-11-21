---- SPLASHES
splashes = {}

function splash_spawn(x, y, n, col, life)
  for i = 1, n do
    local angle = rnd(1) * 2 * 0.785 -- random direction (0..2pi)
    local speed = 1 + rnd(1)
    add(splashes, {
      x = x,
      y = y,
      dx = cos(angle) * speed,
      dy = sin(angle) * speed,
      col = col or 7,
      life = life + flr(rnd(10))
    })
  end
end

function update_splashes()
  -- backward iteration to safely delete elements
  for i = #splashes, 1, -1 do
    local p = splashes[i]
    p.x = p.x + p.dx
    p.y = p.y + p.dy
    p.dy = p.dy + 0.1 -- gravity, optional
    p.life = p.life - 1
    if p.life <= 0 then
      deli(splashes, i)
    end
  end
end
---- SPLASHES

function draw_splashes()
  for p in all(splashes) do
    pset(p.x, p.y, p.col)
  end
end

---- TEXT ANIMATION
text = nil -- if set, text is displayed
text_t = nil
text_duration = 2 -- nil = infinitive
text_x = 0

function text_start(text_to_start, x, duration)
  text = text_to_start
  text_t = t()
  text_x = x
  text_duration = duration
end

function text_update()
  if text_duration and text_t and t() - text_t >=
    text_duration then
    text = NIL
  end
end

function text_draw()
  if not text then
    return
  end
  text_draw_animated(text_x, 2)
end

-- 23,2

-- by copilot
-- TODO add black background. whole width, height of one tile
function text_draw_animated(x0, y0)
  local amplitude = 1
  x0 = x0 or 0
  y0 = y0 or 0
  for i = 1, #text do
    local t1 = t() * 80 + i * 6
    local x = x0 + i * 4
    local y = y0 + sin(t1 / 30) * amplitude
    local ch = sub(text, i, i)
    local col = 8 + flr((sin(t1 / 20) + 1) * 3) -- cycles color 8-14
    print(ch, x, y, col)
  end
end
------ TEXT ANIMATION

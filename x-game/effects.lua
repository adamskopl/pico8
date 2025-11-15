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
  printh(#splashes)
end

function draw_splashes()
  for p in all(splashes) do
    pset(p.x, p.y, p.col)
  end
end

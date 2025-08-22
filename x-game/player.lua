local function draw_gun()
  local flip = p.dir.x == -1
  local dx = (flip and -7) or 7
  spr(5, p.pos.x + dx, p.pos.y + 5, 1, 1, flip)
end

function draw_p()
  local flip = p.dir.x == -1
  spr(1, p.pos.x, p.pos.y, 1, 1, flip)
  draw_gun()
  if p.dir then
    local len = 8
    --  crosshair
    -- circ(p.pos.x + 4 + p.dir.x * len,
    -- p.pos.y + 4 + p.dir.y * len, 1, 8)
  end
end

function shoot()
  sfx(1)
  add(bullets, {
    pos = vec_cp(p.pos),
    dir = vec_cp(p.dir),
    speed = 0.5
  })
end

function draw_bullets()
  for b in all(bullets) do
    pset(b.pos.x, b.pos.y, 10)
  end
end

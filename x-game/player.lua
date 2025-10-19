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
    local len = 6
    --  crosshair
    circ(p.pos.x + 4 + p.dir.x * len,
      p.pos.y + 4 + p.dir.y * len, 1, 8)
  end
end

function shoot()
  sfx(1)

  -- calc pos
  local pos = vec_cp(p.pos)
  pos.y = pos.y + 5
  if p.dir.x == -1 then
    pos.x = pos.x - 2
  elseif p.dir.x == 1 then
    pos.x = pos.x + 10
  else
    pos.x = pos.x + 3
  end
  -- calc pos

  add(bullets, {
    pos = pos,
    dir = vec_cp(p.dir),
    speed = 2
  })

end

function update_bullets()
  for b in all(bullets) do
    update_pos(b)
  end
  for pos, t in pairs(lvl) do
    if t.type == MAP.WALL then
      for b in all(bullets) do
        if vec_inside(b.pos, t.pos) then
          sfx(2)
          del(bullets, b)
        end
      end
    end
  end
end

function draw_bullets()
  for b in all(bullets) do
    pset(b.pos.x, b.pos.y, CFG.COL_BULLET)
  end
end

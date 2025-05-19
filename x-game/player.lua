-- player
function draw_p()
  spr(1, p.pos.x, p.pos.y)
  if p.dir then
    local len = 5
    circ(p.pos.x + 4 + p.dir.x * len, p.pos.y + 4 + p.dir.y * len, 1, 8)
  end
end

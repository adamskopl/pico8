function draw_enemies()
  for e in all(enemies) do
    spr(3, e.x, e.y)
  end
end

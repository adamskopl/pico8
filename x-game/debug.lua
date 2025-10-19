function init_debug()
  lvl_debug = {}
end

function draw_debug()
  for d in all(lvl_debug) do
    rectfill(d.pos.x, d.pos.y, d.pos.x + 7, d.pos.y + 7,
      d.col)
  end
end

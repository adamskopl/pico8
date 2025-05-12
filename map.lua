function init_map()
  objs = {}
  bullets = {}
  enemies = {}
  for i = 0, 15 do
    for j = 0, 15 do
      local tile = mget(i, j)
      if tile == 2 or tile == 5 then
        add(objs, {
          x = i * 8,
          y = j * 8
        })
      end
      if tile == 6 then
        add(enemies, {
          x = i * 8,
          y = j * 8,
          speed = 0.1
        })
      end
    end
  end
end

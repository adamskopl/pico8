function init_map()
  objs = {}
  for i = 0, 15 do
    for j = 0, 15 do
      printh('DUPA')
      printh(mget(i, j))
      local tile = mget(i, j)
      if tile == 2 or tile == 5 then
        printh('add')
        add(objs, {
          x = i * 8,
          y = j * 8,
          active = false
        })
      end
    end
  end
end

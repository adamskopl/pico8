function init_map()
  objs = {}
  for i = 0, 7 do
    for j = 0, 7 do
      printh('DUPA')
      printh(mget(i, j))
      if mget(i, j) == 2 then
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

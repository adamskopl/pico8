function update_enemies()

end

function update_enemies_old_for_ref()
  for e in all(enemies) do
    if not e.m then
      -- TODO some util functions needed...
      local next_m = lvl[v_key(vec_add(e.pos,
        vec_multi(e.dir, 8)))]
      if (next_m and next_m.type == 'W') then
        e.dir = vec_multi(e.dir, -1) -- reverse direction if wall
      end
      start_movement(e)
    end
    update_movement(e)
  end
end

function draw_enemies()
  for e in all(enemies) do
    spr(17, e.pos.x, e.pos.y)
  end
end

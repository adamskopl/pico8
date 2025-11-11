function create_enemy(o)
  o.m = nil
  o.dir = vec(0, 0)
  o.speed = 0.5
  o.sleep = true
end

function can_chase_dir(o, dir)
  local m = mget(o.pos.x / 8 + dir.x, o.pos.y / 8 + dir.y)
  return m ~= MAP.WALL
end

function chase_dir(from, to)
  local dx = abs(to.pos.x - from.pos.x)
  local dy = abs(to.pos.y - from.pos.y)
  for dir in all(DIRS) do
    if can_chase_dir(from, dir) then
      local newPos = vec_add(from.pos, vec_multi(dir, 8))
      local newDx = abs(to.pos.x - newPos.x)
      local newDy = abs(to.pos.y - newPos.y)
      if (newDx < dx) or (newDy < dy) then
        return dir
      end
    end
  end
end

function update_enemies()
  for m in all(monsters) do
    if not m.sleep and not m.m then
      local chase_dir = chase_dir(m, p)
      if chase_dir then
        m.dir = chase_dir
        start_movement(m)
      end
    else
      update_movement(m)
    end
  end

  for e in all(eyes) do
    anim_update(e)
  end
  for m in all(mages) do
    anim_update(m)
  end

end

function draw_enemies()
  for e in all(monsters) do
    spr(MAP.MONSTER, e.pos.x, e.pos.y)
  end
end

function player_enemies_scan()
  -- start scanning
  local m_pos = vec(p.pos.x / 8, p.pos.y / 8)
  for dir in all(DIRS) do
    -- scan in this direction
    local m_pos_next = vec_add(m_pos, dir)
    local m_next = mget(m_pos_next.x, m_pos_next.y)
    while m_next ~= MAP.WALL do
      for e in all(monsters) do
        if e.sleep and
          vec_in_tile(e.pos, vec_multi(m_pos_next, 8)) then
          e.sleep = false
          sfx(SFX.MONSTER_WAKE)
        end
      end
      m_pos_next = vec_add(m_pos_next, dir)
      m_next = mget(m_pos_next.x, m_pos_next.y)
    end
  end
end

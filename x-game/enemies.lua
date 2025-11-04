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
  for e in all(enemies) do
    if not e.sleep and not e.m then
      local chase_dir = chase_dir(e, p)
      if chase_dir then
        e.dir = chase_dir
        start_movement(e)
      end
    else
      update_movement(e)
    end
  end
end

function draw_enemies()
  for e in all(enemies) do
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
      for e in all(enemies) do
        if e.sleep and
          vec_inside(e.pos, vec_multi(m_pos_next, 8)) then
          e.sleep = false
          sfx(3)
          add(lvl_debug, {
            pos = vec_multi(m_pos_next, 8),
            col = 8
          })
        end
      end
      -- add(lvl_debug, {
      --   pos = vec_multi(m_pos_next, 8),
      --   col = 8
      -- })
      m_pos_next = vec_add(m_pos_next, dir)
      m_next = mget(m_pos_next.x, m_pos_next.y)
    end
  end
end

-- add WALL module for walls
function wall_in_pos_m(pos_m)
  local m = mget(pos_m.x, pos_m.y)
  return fget(m, FLAGS.WALL)
end

-- Return the shortest cardinal path from pos_m_from to pos_m_to.
-- The returned array excludes the starting tile and includes the destination.
-- Returns nil if either endpoint is outside the current level, blocked, or unreachable.
function find_path(pos_m_from, pos_m_to)
  if m_offscreen(pos_m_from) or m_offscreen(pos_m_to) or wall_in_pos_m(pos_m_from) or wall_in_pos_m(pos_m_to) then
    return nil
  end

  local start_key = VEC.key(pos_m_from)
  local target_key = VEC.key(pos_m_to)
  local queue = { pos_m_from }
  local parent = { [start_key] = false }
  local positions = {}

  for current in all(queue) do
    local current_key = VEC.key(current)
    if current_key == target_key then
      local path = {}
      while current_key ~= start_key do
        add(path, positions[current_key])
        current_key = parent[current_key]
      end
      for i = 1, flr(#path / 2) do
        local j = #path - i + 1
        path[i], path[j] = path[j], path[i]
      end
      return path
    end

    for dir in all(DIRS) do
      local next_pos = VEC.add(current, dir)
      local next_key = VEC.key(next_pos)
      if parent[next_key] == nil and not m_offscreen(next_pos) and not wall_in_pos_m(next_pos) then
        parent[next_key] = current_key
        positions[next_key] = next_pos
        add(queue, next_pos)
      end
    end
  end

  return nil
end

function pos_m_to_pos(pos_m)
  return VEC.multi(pos_m, 8)
end

function wall_in_dir(o)
  local pos_m = VEC.div(o.pos, 8)
  local pos_m_dir = VEC.add(pos_m, o.dir)
  return wall_in_pos_m(pos_m_dir)
end

function get_pos_m_facing(o)
  local pos, dir = o.pos, o.dir
  local pos_mf_x, pos_mf_y = pos.x / 8, pos.y / 8
  local pos_m =
    VEC.new((dir.x == 1 and ceil(pos_mf_x)) or flr(pos_mf_x), (dir.y == 1 and ceil(pos_mf_y)) or flr(pos_mf_y))
  return pos_m
end

function get_pos_m_mostly_occupied(o)
  return VEC.new(flr((o.pos.x + 4) / 8), flr((o.pos.y + 4) / 8))
end

function m_offscreen(pos_m)
  return (pos_m.x < LEVEL.level.pos.x)
    or (pos_m.x > LEVEL.level.pos.x + 15)
    or (pos_m.y < LEVEL.level.pos.y)
    or (pos_m.y > LEVEL.level.pos.y + 15)
end

TILES = {}
function TILES.touch(a, b)
  return (a.x == b.x and abs(a.y - b.y) == 8) or (a.y == b.y and abs(a.x - b.x) == 8)
end
function TILES.collide(a, b)
  return a.x < b.x + 8 and a.x + 8 > b.x and a.y < b.y + 8 and a.y + 8 > b.y
end
function TILES.small_collide(a, b)
  return a.x < b.x + 4 and a.x + 4 > b.x and a.y < b.y + 4 and a.y + 4 > b.y
end
function TILES.vec_in_tile(v, v_tile)
  return (v.x >= v_tile.x and v.x < v_tile.x + 8) and (v.y >= v_tile.y and v.y < v_tile.y + 8)
end

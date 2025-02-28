ENEMIES = {}
ENEMY_GRUNT = "ENEMY_GRUNT"

function ENEMIES.new(pos_m, type, patrol)
  local e = ENTITY.new(pos_m_to_pos(pos_m))
  e.type = type
  e.speed = 0
  if patrol then
    e.patrol = {
      from_m = patrol.from_m,
      to_m = patrol.to_m,
      target_m = patrol.to_m,
    }
  end
  if type == ENEMY_GRUNT then
    e.speed = 0.7
    MOV.apply(e, e.speed, true)
    ANIM.apply_loop(e, GFX.ENEMY_GRUNT, GFX.ENEMY_GRUNT, GFX.ENEMY_GRUNT + 3, 0.12)
    e.reach = 4
  end
  return e
end

function ENEMIES.load(level)
  enemies = {}
  for l_e in all(level.enemies) do
    local spawn_m = l_e.pos_m or (l_e.patrol and l_e.patrol.from_m)
    local e = ENEMIES.new(spawn_m, l_e.type, l_e.patrol)
    add(enemies, e)
  end
end

function ENEMIES.update()
  for e in all(enemies) do
    ANIM.update(e)
    enemy_update_movement(e)
    MOV.update(e)
  end
end
function enemy_update_movement(e)
  if MOV.moving(e) then
    return
  end
  local pos_m = get_pos_m_mostly_occupied(e)
  local pos_h_m = get_pos_m_mostly_occupied(hero)

  -- pursue
  local path_hero = find_path(pos_m, pos_h_m)
  if path_hero and #path_hero <= e.reach then
    if #path_hero == 0 then
      return
    end
    e.dir = VEC.sub(path_hero[1], pos_m)
    MOV.start(e)
    return
  end

  if not e.patrol then
    return
  end

  -- Resume the existing patrol target after leaving pursuit range.
  if VEC.eq(pos_m, e.patrol.target_m) then
    e.patrol.target_m = VEC.eq(e.patrol.target_m, e.patrol.from_m) and e.patrol.to_m or e.patrol.from_m
  end
  local path = find_path(pos_m, e.patrol.target_m)
  if not path or #path == 0 then
    return
  end
  e.dir = VEC.sub(path[1], pos_m)
  MOV.start(e)
end

function ENEMIES.draw()
  for e in all(enemies) do
    ANIM.draw(e)
  end
end

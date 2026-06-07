function _init()
  printh('--init')

  dir_choice_t = nil
  dir_choice_delay = 0 -- increase in case of restoring dir choice without movement
  mov_interrupted = true

  G = {
    level = nil,
    hero = nil
  }
  lvl_init()
end

function game_keys_update()
  local dir_choice = (btn(0) and VEC.new(-1, 0)) or (btn(1) and VEC.new(1, 0)) or (btn(2) and VEC.new(0, -1)) or
                       (btn(3) and VEC.new(0, 1)) or nil
  


  if dir_choice and not mov_moving(hero) then
    if (not hero.dir) or (not VEC.eq(dir_choice, hero.dir)) then
      -- dir change, measure press time
      hero.dir = dir_choice
      dir_choice_t = time()
    elseif dir_choice_t then
      -- same dir + measuring press time
      if time() - dir_choice_t >= dir_choice_delay then
        dir_choice_t = nil
      end
    else
      if not wall_dir(hero) then
        mov_start(hero)
      end
    end
  else
    dir_choice_t = nil
  end
end

function _update60()
  game_keys_update()
  hero_update()
end

function _draw()
  cls(0)
  map(0, 0, 0, 0, 16, 16)

  line(0, 0, 127, 0, 13)
  line(0, 0, 0, 127, 13)
  line(0, 127, 127, 127, 13)
  line(127, 0, 127, 127, 13)

  hero_draw()
end

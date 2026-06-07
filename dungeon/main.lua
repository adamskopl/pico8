function _init()
  printh('--init')

  dir_choice_t = nil
  dir_choice_delay = 0.1
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

  if not dir_choice or MOV.moving(hero) then
    dir_choice_t = nil
    return
  end

  -- dir change
  if not hero.dir or not VEC.eq(dir_choice, hero.dir) then
    hero.dir = dir_choice
    dir_choice_t = time()
    return
  end

  -- same dir
  if not dir_choice_t or time() - dir_choice_t >= dir_choice_delay then
    if not wall_dir(hero) then
      MOV.start(hero)
    end
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

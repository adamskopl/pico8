function _init()
  printh('')
  printh('--init')

  dir_choice_t = nil
  dir_choice_delay = 0.1
  G = {
    level = nil,
    hero = nil
  }
  LVL.init()
  LOS.init()
end

function game_keys_update()
  local dir_choice = (btn(0) and VEC.from(-1, 0)) or (btn(1) and VEC.from(1, 0)) or (btn(2) and VEC.from(0, -1)) or
                       (btn(3) and VEC.from(0, 1)) or nil
  if dir_choice and not MOV.is_moving(G.hero) then
    if not VEC.eq(dir_choice, G.hero.dir) then
      -- dir change, measure press time
      G.hero.dir = dir_choice
      dir_choice_t = time()
    elseif dir_choice_t then
      -- same dir + measuring press time
      if time() - dir_choice_t >= dir_choice_delay then
        dir_choice_t = nil
      end
    else
      MOV.start(G.hero)
    end
  else
    dir_choice_t = nil
  end

  if (btn(4)) then
  end
end

function _update60()
  game_keys_update()
  HERO.update()
  -- LOS.update()
end

function _draw()
  camera()
  cls(COLORS.BLACK)
  rect(0, 0, 127, 127, COLORS.RED)

  camera(SCREEN.v_camera())
  LVL.draw()
  HERO.draw()
  -- LOS.draw()
end

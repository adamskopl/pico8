function _init()
  printh('--init')

  dir_choice_t = nil
  dir_choice_delay = 0.1
  G = {
    level = nil,
    player = nil
  }
  LVL.init()
end

function game_keys_update()
  local dir_choice = (btn(0) and VEC.from(-1, 0)) or
      (btn(1) and VEC.from(1, 0)) or
      (btn(2) and VEC.from(0, -1)) or
      (btn(3) and VEC.from(0, 1)) or nil
  if dir_choice and not MOV.is_moving(G.player) then
    if not VEC.eq(dir_choice, G.player.dir) then
      -- dir change, measure press time
      G.player.dir = dir_choice
      dir_choice_t = time()
    elseif dir_choice_t then
      -- same dir + measuring press time
      if time() - dir_choice_t >= dir_choice_delay then
        dir_choice_t = nil
      end
    else
      MOV.start(G.player)
    end
  else
    dir_choice_t = nil
  end

  if (btn(4)) then
  end
end

function _update60()
  game_keys_update()
  PLAYER.update()
end

function _draw()
  camera()
  cls(COLORS.BLACK)
  rect(0, 0, 127, 127, COLORS.RED)

  camera(G.player.vec.x - 64, G.player.vec.y - 64)
  LVL.draw()
  PLAYER.draw()
end

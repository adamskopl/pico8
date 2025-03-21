function _init()
  player = {
    x = 128 / 2 - 8,
    y = 128 - 16
  }
end

function _update()
end

function _draw()
  cls()
  spr(1, player.x, player.y, 2, 2)
end

GAME_WIN = {}

function GAME_WIN.start() end

function GAME_WIN.update()
  MOV.update(hero)
  ANIM.update(hero)
end

function GAME_WIN.draw()
  cls(COLORS.DARK_BLUE)
  CAMERA.apply(LEVEL.level.pos.x * 8, LEVEL.level.pos.y * 8)

  HERO.draw()
end

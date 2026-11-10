GAME_WIN = {}
GW_CHEST_DELAY = 1
gw_started_at = nil
gw_chest_pos = nil

function GAME_WIN.start()
  gw_started_at = time()
  gw_chest_pos = nil
end

function GAME_WIN.update()
  MOV.update(hero)
  ANIM.update(hero)

  if not gw_chest_pos and time() - gw_started_at >= GW_CHEST_DELAY then
    gw_chest_pos = VEC.sub(hero.pos, VEC.multi(hero.dir, 9))
    hero.dir = VEC.multi(hero.dir, -1)
    EFFECTS.create_arrival(gw_chest_pos)
  end
end

function GAME_WIN.draw()
  cls(COLORS.DARK_BLUE)
  CAMERA.apply(LEVEL.level.pos.x * 8, LEVEL.level.pos.y * 8)
  HERO.draw()
  if gw_chest_pos then
    spr(GFX.CHEST, gw_chest_pos.x, gw_chest_pos.y)
  end
  ANIM.draw_singles()
end

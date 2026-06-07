LVL_1 = {
  pos = VEC.new(0, 0),
  hero = VEC.new(1, 1)
}

LVL_2 = {
  pos = VEC.new(1, 0),
  hero = VEC.new(0, 0)
}

function lvl_init()
  G.level = LVL_1
  G.hero = hero_new(VEC.multi(G.level.hero,8))
end

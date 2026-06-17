LEVEL = {}

LEVEL_1 = {
  pos = VEC.new(1, 1),
  hero = VEC.new(2, 2)
}

LEVEL_2 = {
  pos = VEC.new(18, 1),
  hero = VEC.new(19, 2)
}

function LEVEL.init()
  G.level = LEVEL_2
  G.hero = hero_new(VEC.multi(G.level.hero, 8))
end

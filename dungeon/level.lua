LEVEL = {}

LEVEL_1 = {
  pos = VEC.new(1, 1),
  hero = VEC.new(2, 2),
  coins = {VEC.new(3, 3), VEC.new(4, 3), VEC.new(5, 3), VEC.new(6, 3),
           VEC.new(8, 4)}
}

LEVEL_2 = {
  pos = VEC.new(18, 1),
  hero = VEC.new(19, 2),
  coins = {}
}

function LEVEL.init()
  G.level = LEVEL_1
  G.hero = HERO.new(VEC.multi(G.level.hero, 8))
  COINS.load()
end

HERO = {}
function HERO.new(pos)
	local h = {
		flip = false,
	}
	MOV.init(h, VEC.cp(pos))
	ANIM.create_loop(h, 164, 164, 167, 0.04)
	return h
end

function HERO.update()
	MOV.update(G.hero)
	ANIM.update(G.hero)
	teleport_update()

	-- COINS COLLISION
	for i = #G.coins, 1, -1 do
		if TILES.collide(G.hero.pos, G.coins[i].pos) then
			deli(G.coins, i)
			sfx(SFX.COIN)
		end
	end
end
function teleport_update()
	if not G.hero.dir then
		return
	end

	DEBUGGER.clear()
	local h = G.hero
	local pos_m_now = pos_to_pos_m(h.pos, h.dir)
	local pos_m_next = VEC.add(pos_m_now, h.dir)
	-- printh(VEC.to_str(G.hero.pos) .. " " .. VEC.to_str(pos_next))
	DEBUGGER.add_orange(VEC.multi(pos_m_now, 8))
	DEBUGGER.add_green(VEC.multi(pos_m_next, 8))
	printh(wall_in_pos_m(pos_m_next))
	while not wall_in_pos_m(pos_m_next) do
		pos_m_next = VEC.add(pos_m_next, h.dir)
		DEBUGGER.add_green(VEC.multi(pos_m_next, 8))
	end
end

-- TODO will be replaced with showing teleport mark
function draw_crosshair()
	local len = 8
	circ(G.hero.pos.x + 4 + G.hero.dir.x * len, G.hero.pos.y + 4 + G.hero.dir.y * len, 1, 8)
end
function HERO.draw()
	ANIM.draw(G.hero)
	if G.hero.dir then
		draw_crosshair()
	end
end

COINS = {}
function COINS.new(pos)
	local c = {}
	MOV.init(c, VEC.cp(pos))
	ANIM.create_loop(c, GFX.COIN, GFX.COIN, GFX.COIN + 3, 0.1)
	ANIM.start(c)
	return c
end
function COINS.load(level)
	G.coins = {}
	for c_pos in all(level.coins) do
		local c = COINS.new(VEC.multi(c_pos, 8))
		add(G.coins, c)
	end
end
function COINS.update()
	for c in all(G.coins) do
		ANIM.update(c)
	end
end
function COINS.draw()
	for c in all(G.coins) do
		ANIM.draw(c)
	end
end

LEVEL = {
	index = nil,
	level = nil,
	levels = nil,

	timer_button_start = nil,
	let_close_intro = false,
}

LEVEL_1 = {
	title = "Level 1",
	pos = VEC.new(1, 1),
	hero = VEC.new(2, 2),
	coins = { VEC.new(3, 2), VEC.new(4, 2), VEC.new(5, 2) },
}
LEVEL_2 = {
	title = "Level 2",
	pos = VEC.new(18, 1),
	hero = VEC.new(19, 2),
	coins = { VEC.new(20, 3) },
}
LEVEL_EMPTY = {
	title = "EMPTY",
	pos = VEC.new(1, 1),
	hero = VEC.new(19, 2),
	coins = { VEC.new(20, 3) },
}
LEVEL.levels = { LEVEL_1, LEVEL_2, LEVEL_EMPTY }

function LEVEL.load_next()
	printh("load level next")
	LEVEL.timer_button_start = time()
	LEVEL.let_close_intro = false
	if LEVEL.index == nil then
		LEVEL.index = 1
	else
		LEVEL.index = LEVEL.index + 1
	end

	LEVEL.level = LEVEL.levels[LEVEL.index]
	G.hero = HERO.new(VEC.multi(LEVEL.level.hero, 8))
	COINS.load(LEVEL.level)
end

function LEVEL.update()
	if STATE.state == STATE.LEVEL_INTRO then
		if CONFIG.SKIP_INTRO then
			STATE.change(STATE.PLAYING)
		end
		if not LEVEL.let_close_intro and time() - LEVEL.timer_button_start > 2 then
			LEVEL.let_close_intro = true
			TEXT.start_blinking()
		end
		if LEVEL.let_close_intro then
			TEXT.update_blinking()
			if any_pressed() then
				STATE.change(STATE.PLAYING)
			end
		end
	end
end

function LEVEL.draw_level_intro()
	camera()
	cls(COLORS.DARK_BLUE)
	TEXT.print_center("level " .. LEVEL.index, COLORS.YELLOW)
	TEXT.draw_blinking("press a key...", 128 - 60, 128 - 10, COLORS.YELLOW)
end

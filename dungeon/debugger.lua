DEBUGGER = {
	TILES_ORANGE = {},
	TILES_GREEN = {},
	clear = function()
		DEBUGGER.TILES_ORANGE = {}
		DEBUGGER.TILES_GREEN = {}
	end,
	add_orange = function(pos_m)
		add(DEBUGGER.TILES_ORANGE, pos_m)
	end,
	add_green = function(pos_m)
		add(DEBUGGER.TILES_GREEN, pos_m)
	end,
	draw = function()
		for pos_m in all(DEBUGGER.TILES_ORANGE) do
			rect(pos_m.x * 8, pos_m.y * 8, pos_m.x * 8 + 7, pos_m.y * 8 + 7, COLORS.ORANGE)
		end
		for pos_m in all(DEBUGGER.TILES_GREEN) do
			rect(pos_m.x * 8, pos_m.y * 8, pos_m.x * 8 + 7, pos_m.y * 8 + 7, COLORS.GREEN)
		end
	end,
}

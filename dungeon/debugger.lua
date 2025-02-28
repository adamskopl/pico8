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
			local pos = pos_m_to_pos(pos_m)
			rect(pos.x, pos.y, pos.x + 7, pos.y + 7, COLORS.ORANGE)
		end
		for pos_m in all(DEBUGGER.TILES_GREEN) do
			local pos = pos_m_to_pos(pos_m)
			rect(pos.x, pos.y, pos.x + 7, pos.y + 7, COLORS.GREEN)
		end
	end,
}

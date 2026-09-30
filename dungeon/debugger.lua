DEBUGGER = {
	TILES_ORANGE = {},
	TILES_GREEN = {},
	clear = function()
		DEBUGGER.TILES_ORANGE = {}
		DEBUGGER.TILES_GREEN = {}
	end,
	add_orange = function(tile)
		add(DEBUGGER.TILES_ORANGE, tile)
	end,
	add_green = function(tile)
		add(DEBUGGER.TILES_GREEN, tile)
	end,
	draw = function()
		for tile in all(DEBUGGER.TILES_ORANGE) do
			rect(tile.x, tile.y, tile.x + 7, tile.y + 7, COLORS.ORANGE)
		end
		for tile in all(DEBUGGER.TILES_GREEN) do
			rect(tile.x, tile.y, tile.x + 7, tile.y + 7, COLORS.GREEN)
		end
	end,
}

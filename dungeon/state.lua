STATE = {
	LEVEL_INTRO = "LEVEL_INTRO",
	PLAYING = "PLAYING",
	state = nil,
}

function STATE.change(newState)
	printh("state " .. newState)
	STATE.state = newState

	if newState == STATE.LEVEL_INTRO then
		LEVEL.load_next()
	elseif STATE == STATE.PLAYING then
	end
end

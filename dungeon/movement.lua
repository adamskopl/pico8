MOV = {}

function MOV.init(o, pos)
	o.pos = pos
	o.dir = nil -- maybe should be [0,0] instead
	o.mov = {
		on = false,
		speed = 1,
		pos_start = nil,
	}
end

function MOV.moving(o)
	return o.mov.on
end

function MOV.start(o)
	o.mov.on = true
	o.mov.pos_start = VEC.new(o.pos.x, o.pos.y)
	if o.anim.stop then
		ANIM.start(o)
	end
end

function MOV.update(o)
	if not o.mov.on then
		if not o.anim.stop then
			ANIM.stop(o)
		end
		return
	end
	o.pos.x = o.pos.x + o.dir.x * o.mov.speed
	o.pos.y = o.pos.y + o.dir.y * o.mov.speed
	if abs(o.mov.pos_start.x - o.pos.x) >= 8 or abs(o.mov.pos_start.y - o.pos.y) >= 8 then
		o.pos.x = o.mov.pos_start.x + o.dir.x * 8
		o.pos.y = o.mov.pos_start.y + o.dir.y * 8
		o.mov.on = false
	end
end

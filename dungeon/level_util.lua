function wall_in_pos_m(pos_m)
	local m = mget(pos_m.x, pos_m.y)
	return fget(m, FLAGS.WALL)
end

function wall_in_dir(o)
	local pos_m = VEC.div(o.pos, 8)
	local pos_m_dir = VEC.add(pos_m, o.dir)
	return wall_in_pos_m(pos_m_dir)
end

function pos_to_pos_m(pos, dir)
	local pos_mf_x, pos_mf_y = pos.x / 8, pos.y / 8
	local pos_m = VEC.new(
		(dir.x == -1 and ceil(pos_mf_x)) or (dir.x == 1 and flr(pos_mf_x)) or pos_mf_x,
		(dir.y == -1 and ceil(pos_mf_y)) or (dir.y == 1 and flr(pos_mf_y)) or pos_mf_y
	)
	return pos_m
end

function m_offscreen(pos_m)
	return (pos_m.x < LEVEL.level.pos.x)
		or (pos_m.x > LEVEL.level.pos.x + 15)
		or (pos_m.y < LEVEL.level.pos.y)
		or (pos_m.y > LEVEL.level.pos.y + 15)
end

TILES = {}
function TILES.touch(a, b)
	return (a.x == b.x and abs(a.y - b.y) == 8) or (a.y == b.y and abs(a.x - b.x) == 8)
end
function TILES.collide(a, b)
	return a.x < b.x + 8 and a.x + 8 > b.x and a.y < b.y + 8 and a.y + 8 > b.y
end
function TILES.small_collide(a, b)
	return a.x < b.x + 4 and a.x + 4 > b.x and a.y < b.y + 4 and a.y + 4 > b.y
end
function TILES.vec_in_tile(v, v_tile)
	return (v.x >= v_tile.x and v.x < v_tile.x + 8) and (v.y >= v_tile.y and v.y < v_tile.y + 8)
end

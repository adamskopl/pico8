function vec(x, y)
  return {
    x = x,
    y = y
  }
end

function vec_cp(v)
  return vec(v.x, v.y)
end

function vec_eq(v1, v2)
  return v1.x == v2.x and v1.y == v2.y
end

function vec_multi(v, number)
  return {
    x = v.x * number,
    y = v.y * number
  }
end

function vec_add(v1, v2)
  return {
    x = v1.x + v2.x,
    y = v1.y + v2.y
  }
end

function tiles_touch(a, b)
  return (a.x == b.x and abs(a.y - b.y) == 8) or
           (a.y == b.y and abs(a.x - b.x) == 8)
end

function tiles_collide(a, b)
  return
    a.x < b.x + 8 and a.x + 8 > b.x and a.y < b.y + 8 and
      a.y + 8 > b.y
end

function tiles_small_collide(a, b)
  return
    a.x < b.x + 4 and a.x + 4 > b.x and a.y < b.y + 4 and
      a.y + 4 > b.y
end

function vec_in_tile(v, v_tile)
  return v.x >= v_tile.x and v.x < v_tile.x + 8 and v.y >=
           v_tile.y and v.y < v_tile.y + 8
end

function vec_key(pos)
  return pos.x .. "_" .. pos.y
end

DIRS = {{
  x = 0,
  y = -1
}, {
  x = 1,
  y = 0
}, {
  x = 0,
  y = 1
}, {
  x = -1,
  y = 0
}}

DIRS_8 = {{
  x = -8,
  y = 0
}, {
  x = 8,
  y = 0
}, {
  x = 0,
  y = -8
}, {
  x = 0,
  y = 8
}}

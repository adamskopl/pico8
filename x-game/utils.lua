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

function touching(a, b)
  return (a.x == b.x and abs(a.y - b.y) == 8) or
           (a.y == b.y and abs(a.x - b.x) == 8)
end

function pos_key(pos)
  return pos.x .. "_" .. pos.y
end

DIRS = {{
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


VEC = {}
function VEC.from(x, y)
  return {
    x = x,
    y = y
  }
end

function VEC.cp(v)
  return VEC.from(v.x, v.y)
end

function VEC.eq(v1, v2)
  return v1.x == v2.x and v1.y == v2.y
end

function VEC.multi(v, number)
  return {
    x = v.x * number,
    y = v.y * number
  }
end

function VEC.div(v, number)
  return {
    x = v.x / number,
    y = v.y / number
  }
end

function VEC.add(v1, v2)
  return {
    x = v1.x + v2.x,
    y = v1.y + v2.y
  }
end

function VEC.key(v)
  return v.x .. "_" .. v.y
end

function VEC.to_str(v)
  return '[' .. v.x .. ',' .. v.y .. ']'
end

DIRS = { {
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
} }

DIRS_8 = { {
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
} }

DIRS_8_ALL = {
  { x = 0, y = -8 }, { x = 8, y = -8 }, { x = 8, y = 0 },
  { x = 8, y = 8 }, { x = 0, y = 8 }, { x = -8, y = 8 }, { x = -8, y = 0 }, { x = -8, y = -8 }
}

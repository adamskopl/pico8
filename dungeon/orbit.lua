ORBITS = {}

function ORBITS.apply(o, num, radius, speed) -- attach to an object
  o.orbits = {}
  radius = radius or 7
  speed = speed or 0.015

  local angle_step = 1 / num
  for i = 0, num - 1 do
    local orbit = orbit_new(i * angle_step, radius, speed, COLORS.BLUE, COLORS.BLUE)
    add(o.orbits, orbit)
  end
end
function orbit_new(angle, radius, speed, color, trail_color)
  return {
    angle = angle,
    radius = radius,
    speed = speed,
    color = color,
    trail_color = trail_color,
  }
end

function ORBITS.new(pos, radius, speed)
  local o = ENTITY.new(pos)
  ORBITS.apply(o, 1, radius, speed)
  add(mana_orbits, o)
end

function ORBITS.update(o)
  for orbit in all(o.orbits) do
    orbit.angle = (orbit.angle + orbit.speed) % 1
  end
end

function ORBITS.draw(o)
  for orbit in all(o.orbits) do
    local center = VEC.add(o.pos, VEC.new(4, 4))
    local a = orbit.angle
    local trail_a = a - 0.03
    pset(center.x + cos(a) * orbit.radius, center.y + sin(a) * orbit.radius, orbit.color)
    pset(center.x + cos(trail_a) * orbit.radius, center.y + sin(trail_a) * orbit.radius, orbit.trail_color)
  end
end

function ORBITS.count(o)
  return #o.orbits
end

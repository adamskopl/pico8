FLOATING = {}
FLOATING_STEP_DELAY = 0.18

function FLOATING.apply(o, distance, step_delay)
  o.floating = {
    base_y = o.pos.y,
    distance = distance or 3,
    step_delay = step_delay or FLOATING_STEP_DELAY,
    next_step_t = time() + (step_delay or FLOATING_STEP_DELAY),
    offset = 0,
    direction = -1,
  }
end

function FLOATING.update(o)
  local f = o.floating
  if not f then
    return
  end

  local now_t = time()
  while now_t >= f.next_step_t do
    if f.offset >= f.distance then
      f.direction = -1
    elseif f.offset <= -f.distance then
      f.direction = 1
    end

    f.offset = f.offset + f.direction
    f.next_step_t = f.next_step_t + f.step_delay
  end

end

function timer_create(dt, cb_start, cb_end)
  return {
    set_time = nil,
    dt = dt,
    cb_start = cb_start,
    cb_end = cb_end
  }
end

function timer_start(timer)
  timer.set_time = time()
  timer.cb_start()
end

function timer_update(timer)
  if timer.set_time == nil then
    return
  end
  if (time() - timer.set_time) >= timer.dt then
    timer.set_time = nil
    timer.cb_end()
  end
end

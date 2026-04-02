ANIM = {}

function ANIM.draw(o)
  local flip = o.dir.x == -1
  spr(o.anim.frame, o.vec.x, o.vec.y, 1, 1, flip)
end

function ANIM.create_loop(o, frame_idle, frame_s, frame_e, speed)
  o.anim = {
    stop = true,
    frame_idle = frame_idle,
    frame_s = frame_s,
    frame_e = frame_e,
    frame = frame_idle,
    speed = speed,
    time = time(),
    type = "LOOP"
  }
end

function ANIM.create_single(o, frame_idle, frame_s, frame_e, speed)
  o.anim = {
    stop = true,
    frame_idle = frame_idle,
    frame_s = frame_s,
    frame_e = frame_e,
    frame = frame_idle,
    speed = speed,
    time = time(),
    type = "SINGLE"
  }
end

function ANIM.create_cont_reverse(o, frame_s, frame_e, speed, interval)
  o.anim = {
    frame_s = frame_s,
    frame_e = frame_e,
    frame = frame_s,
    speed = speed,
    interval = interval,
    time = time(),
    forward = true, -- false = backward,
    pause = true,
    type = "CONT_REVERSE"
  }
end

function ANIM.stop(o)
  o.anim.stop = true
  o.anim.frame = o.anim.frame_idle
end

function ANIM.start(o)
  o.anim.stop = false
  o.anim.time = time()
  o.anim.frame = o.anim.frame_s
end

function ANIM.update(o)
  local anim = o.anim
  if anim.type == "SINGLE" then
    if anim.stop == true then
      return
    end
    if (time() - anim.time) >= anim.speed then
      anim.time = time()
      anim.frame = anim.frame + 1
      if anim.frame > anim.frame_e then
        anim.stop(o)
      end
    end
  elseif (anim.type == "CONT_REVERSE") then
    if anim.pause then
      if (time() - anim.time) >= anim.interval then
        anim.time = time()
        anim.pause = false
      else
        return
      end
    end
    if (time() - anim.time) >= anim.speed then
      anim.time = time()
      anim.frame = anim.frame + (anim.forward and 1 or -1)

      if anim.frame > anim.frame_e then
        anim.forward = false
        anim.frame = anim.frame_e - 1 -- start going back
      elseif anim.frame < anim.frame_s then
        anim.forward = true
        anim.frame = anim.frame_s
        -- full cycle finished
        anim.pause = true
      end
    end
  elseif anim.type == "LOOP" then
    if anim.stop == true then
      return
    end
    if (time() - anim.time) >= anim.speed then
      anim.time = time()
      anim.frame = anim.frame + 1
      if anim.frame > anim.frame_e then
        anim.frame = anim.frame_s
      end
    end
  end
end

CAMERA = {
  shake_time = 0,
  shake_strength = 0,
  shake_x = 0,
  shake_y = 0,
}

-- Call shake_camera(duration_in_seconds, strength_in_pixels) to shake the view.
function shake_camera(duration, strength)
  CAMERA.shake_time = duration or 0.25
  CAMERA.shake_strength = strength or 2
end

function CAMERA.update()
  if CAMERA.shake_time > 0 then
    CAMERA.shake_time = max(0, CAMERA.shake_time - 1 / 60)
    CAMERA.shake_x = rnd(CAMERA.shake_strength * 2) - CAMERA.shake_strength
    CAMERA.shake_y = rnd(CAMERA.shake_strength * 2) - CAMERA.shake_strength
  else
    CAMERA.shake_x = 0
    CAMERA.shake_y = 0
  end
end

function CAMERA.apply(x, y)
  camera(x + CAMERA.shake_x, y + CAMERA.shake_y)
end

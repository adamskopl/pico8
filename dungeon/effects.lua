EFFECTS = {
  BLINK_FREQ_LOW = 0.2,
  BLINK_FREQ_HIGH = 0.05,
}

function EFFECTS.create_arrival(pos)
  ANIM.create_single(pos, GFX.EXPLOSION, GFX.EXPLOSION + 7, 0.04)
  sfx(SFX.TELEPORT)
end
function EFFECTS.create_disappear(pos)
  ANIM.create_single(pos, GFX.DUST, GFX.DUST + 3, 0.04)
  sfx(SFX.TELEPORT)
end

function EFFECTS.apply_blinking(entity, frequency)
  entity.blinking = {
    time = time(),
    apply_red = true,
    frequency = frequency,
  }
end

function EFFECTS.update(entity)
  local blinking = entity.blinking
  if blinking then
    local time_diff = time() - blinking.time
    if time_diff >= blinking.frequency then
      blinking.time = time()
      blinking.apply_red = not blinking.apply_red
    end
  end
end

function EFFECTS.before_spr(entity)
  if entity.blinking then
    if entity.blinking.apply_red then
      pal(COLORS.YELLOW, COLORS.RED)
    else
      pal()
    end
  end
end

function EFFECTS.after_spr()
  pal()
end

cfg = {
  mar = 2
}

function _update()
end

function _draw()
  cls(1)
  spr(0, cfg.mar, cfg.mar, 2, 2)
  rect(2 * cfg.mar + 16, cfg.mar, 127 - cfg.mar, 64 - cfg.mar, 3)
  spr(0, 128 - cfg.mar - 16, 63 + cfg.mar, 2, 2)
  rect(cfg.mar, 63 + cfg.mar, 127 - cfg.mar * 2 - 16, 128 - cfg.mar, 3)
end


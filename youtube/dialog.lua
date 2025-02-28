cfg = {
  mar = 2,
  txt_on_c = 1,
  txt_off_c = 5,
  bg = 6,
  char_speed = 0.066,
  pause_dialog = 1
}

dt = 0
last_t = 0

anim = {
  create = function(n, x, y, f_x)
    return {
      start_n = n,
      n = n,
      x = x,
      y = y,
      f_x = f_x,
      dt = 0,
      fin = true
    }
  end,
  start = function(self)
    self.fin = false
  end,
  update = function(self)
    if (self.fin) then
      self.n = self.start_n
      return
    end
    self.dt = self.dt + dt
    if (self.dt > 0.08) then
      self.dt = 0;
      self.n = self.n + 2; -- sprite 16px
      if (self.n == self.start_n + 4) then
        self.n = self.start_n
      end
    end
  end,
  draw = function(self)
    spr(self.n, self.x, self.y, 2, 2, self.f_x)
  end
}

text = {
  create = function(x, y)
    return {
      t = "",
      t_fin = "",
      x = x,
      y = y,
      c = cfg.txt_on_c,
      t_pos = 0,
      dt = 0,
      fin = true
    }
  end,
  start = function(self, t)
    -- sfx(0)
    self.t = ""
    self.t_fin = t
    self.c = cfg.txt_on_c
    self.t_pos = 0
    self.dt = 0
    self.fin = false
  end,
  update = function(self)
    if (self.fin) then
      return
    end
    self.dt = self.dt + dt
    if (self.dt > cfg.char_speed) then
      self.dt = 0
      self.t_pos = self.t_pos + 2
      self.t = sub(self.t_fin, 0, self.t_pos)
      if (self.t_pos > #self.t_fin) then
        self.fin = true
        sfx(0, -2)
        return
      end
    end
  end,
  draw = function(self)
    print(self.t, self.x, self.y, self.c)
  end
}

text1 = text.create(2 * cfg.mar + 16, cfg.mar)
anim1 = anim.create(0, cfg.mar, cfg.mar, false)
text2 = text.create(cfg.mar, 63 + cfg.mar, c2)
anim2 = anim.create(32, 128 - cfg.mar - 16, 63 + cfg.mar, true)

manager = {
  mess_i = 1,
  anim = anim1,
  text = text2, -- switch to text1 at start
  dt = 0,
  pause = true,
  update = function(self)
    if self.text.fin and self.mess_i ~= #messages + 1 then
      if self.pause == true then
        self.dt = self.dt + dt
        if self.dt > cfg.pause_dialog then
          self.dt = 0
          self.pause = false
        end
      else
        self:switchActor()
        if messages[self.mess_i] ~= "" then
          text.start(self.text, messages[self.mess_i])
          self.pause = true
        end
        self.mess_i = self.mess_i + 1
      end
    end
  end,
  switchActor = function(self)
    self.text.c = cfg.txt_off_c
    self.text = self.text == text1 and text2 or text1
  end
}

function _init()
  printh("----init----")
end

function _update()
  dt = time() - last_t
  last_t = time()
  manager:update()
  text.update(text1)
  anim1.fin = text1.fin
  anim.update(anim1)
  text.update(text2)
  anim2.fin = text2.fin
  anim.update(anim2)
end

function _draw()
  cls(cfg.bg)
  --	rect(2 * cfg.mar + 16, cfg.mar, 127 - cfg.mar, 64 - cfg.mar, 2)
  --	rect(cfg.mar, 63 + cfg.mar, 127 - cfg.mar * 2 - 16, 128 - cfg.mar, 2)

  text.draw(text1)
  anim.draw(anim1)
  text.draw(text2)
  anim.draw(anim2)
end

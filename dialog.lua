cfg = {
  mar = 2,
  txt_on_c = 17,
  txt_off_c = 5,
  bg = 6
}

delta = 0
last_t = 0

anim = {
  create = function(n, x, y, f_x)
    printh(x)
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
      return
    end
    self.dt = self.dt + delta
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
  create = function(t, x, y, c)
    return {
      t = "",
      t_fin = t,
      x = x,
      y = y,
      c = c,
      t_pos = 0,
      delta = 0,
      fin = true
    }
  end,
  start = function(self, anim)
    if (anim) then
      sfx(0)
      self.fin = false
    else
      self.t = self.t_fin
    end
  end,
  update = function(self)
    if (self.fin) then
      return
    end
    self.delta = self.delta + delta
    if (self.delta > 0.05) then
      self.delta = 0
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

-- >8
-- dialog

mess_print = 2

mess_1 = [[
let's start with something1
simple.
let's start with something1
simple.
let's start with something1
simple.
let's start with something1
simple.
let's start with something1
simple.
]]

mess_2 = [[
yes, let's do it solllll123
yes, let's do it solllll123
yes, let's do it solllll123
]]

-- >8
-- declarations

local c1, c2 = cfg.txt_off_c, cfg.txt_on_c
if mess_print == 1 then
  c1, c2 = c2, c1
end
text1 = text.create(mess_1, 2 * cfg.mar + 16, cfg.mar, c1)
anim1 = anim.create(0, cfg.mar, cfg.mar, false)

text2 = text.create(mess_2, cfg.mar, 63 + cfg.mar, c2)
anim2 = anim.create(32, 128 - cfg.mar - 16, 63 + cfg.mar, true)

-- >8
-- main
function _init()
  if (mess_print == 1) then
    anim.start(anim1)
    text.start(text1, true)
    text.start(text2, false)
  else
    text.start(text1, false)
    anim.start(anim2)
    text.start(text2, true)
  end
end

function _update()
  delta = time() - last_t
  last_t = time()

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

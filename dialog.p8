pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
cfg = {
	mar = 2,
	txt_on_c = 10,
	txt_off_c = 6,
	bg = 3
}

delta=0
last_t=0

anim = {
	create = function(n)
		return {
			start_n = n,
			n = n,
			dt = 0,
			fin = true
		}
	end,
	start = function(self)
		self.fin = false
	end,
	update = function(self)
		self.dt += delta
		if (self.dt > 0.06) then
			self.dt = 0;
			self.n += 2; --sprite 16px
			if (self.n == self.start_n + 6) then
				self.n = self.start_n
			end
		end
	end
}

text={
	create = function()
		return {
			t = "",
			t_pos = 0,
			delta = 0,
			fin = false, 
		}
	end,
	start = function(self)
		sfx(0)
	end,
	update = function(self)
		if (self.fin) then return end
		self.delta += delta
		if (self.delta > 0.05) then
			self.delta = 0
			self.t_pos += 2
			self.t = sub(mess_1,0,self.t_pos)
			if (self.t_pos > #mess_1) then
				self.fin = true
				sfx(0, -2)
				return
			end 
		end
	end,
	print = function(self)
		local c1, c2 = cfg.txt_off_c, cfg.txt_on_c
		if mess_print == 1 then
			c1, c2 = c2, c1
		end
		print(self.t, 2 * cfg.mar + 16, cfg.mar, c1)
		print(self.t, cfg.mar, 63 + cfg.mar, c2)
	end
}

-->8
-- dialog

mess_print = 1 -- 1 or 2.

mess_1=[[
let's start with something
simple.
]]

mess_2=[[
let's start with something
simple.
]]
-->8
-- declarations

text1 = text.create()
text2 = text.create()
anim1 = anim.create(32)
anim2 = anim.create(32)


-->8
-- main
function _init()

end

function _update()
	delta=time()-last_t
	last_t=time()

	text.update(text1)
	text.update(text2)
	anim.update(anim1)
	anim.update(anim2)
end

function _draw()
	cls(cfg.bg)
	spr(anim1.n, cfg.mar, cfg.mar, 2, 2)
--	rect(2 * cfg.mar + 16, cfg.mar, 127 - cfg.mar, 64 - cfg.mar, 2)
	spr(0, 128 - cfg.mar - 16, 63 + cfg.mar, 2, 2, true)
--	rect(cfg.mar, 63 + cfg.mar, 127 - cfg.mar * 2 - 16, 128 - cfg.mar, 2)
	text.print(text1)
	text.print(text2)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000011110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000115511000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001155551100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00011515115100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00011151111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001151a11a100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001511111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001511111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00011151111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00015155115100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00155115555110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00155115551110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00151111551110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00111111511110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010011110100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001110000000000000111000000000000011100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00016771000000000001677100000000000167710000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00166777100000000016677710000000001667771000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00166171111000000016617110000000001661711000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00016777551100000001677711100000000167771110000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001671155110000000167155110000000016715511000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001d111111100000001d111551100000001d111551100000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001611a11a10000000161111111000000016111111100000000000000000000000000000000000000000000000000000000000000000000000000000000000
000015114664100000001511a11a100000001511a11a100000000000000000000000000000000000000000000000000000000000000000000000000000000000
000015116dd610000000151146641000000015114664100000000000000000000000000000000000000000000000000000000000000000000000000000000000
00014f15d66d110000014f116dd6110000014f116dd6100000000000000000000000000000000000000000000000000000000000000000000000000000000000
00014f115661111000014f15d66d111000014f15d66d110000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001515111555100000151556655510000015115661111000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000151155514f100000151155514f10000015151115551000000000000000000000000000000000000000000000000000000000000000000000000000000000
000015115551110000001511555111000000151155514f1000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001511555110000000151155511000000015115551110000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000200042b3733131332313373732730317303153031b3031b3031a3030f3032a3032a3032a303293032930300303003030030300303003030030300303003030030300303003030030300303003030030300300
__music__
00 00024344


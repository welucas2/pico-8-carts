pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

field = {}
field.minx = 0
field.miny = 0
field.maxx = 128
field.maxy = 120

rowsdower = {}
rowsdower.x = 20
rowsdower.y = 20
rowsdower.width = 16
rowsdower.height = 16

character_speed = 1

enemies = {}
sprite_ref = {}
sprite_ref.c = 32

function init_cultist()
 cultist = {}
 cultist.type = 'c'
 cultist.x = 100
 cultist.y = 100
 cultist.health = 20
 return cultist
end

function draw_enemies()
 for i, enemy in pairs(enemies) do
  spr(sprite_ref[enemy.type], enemy.x, enemy.y, 2, 2)
 end
end

function move_rowsdower()
 if btn(0) then
  rowsdower.x -= character_speed
 elseif btn(1) then
  rowsdower.x += character_speed
 elseif btn(2) then
  rowsdower.y -= character_speed
 elseif btn(3) then
  rowsdower.y += character_speed
 end
 rowsdower.x = max(rowsdower.x, field.minx)
 rowsdower.x = min(rowsdower.x, field.maxx-rowsdower.width)
 rowsdower.y = max(rowsdower.y, field.miny)
 rowsdower.y = min(rowsdower.y, field.maxy-rowsdower.height)
end

function init_level(level_number)
 if level_number == 1 then
  enemies[1] = init_cultist()
 end
end

function _init()
 cls()
 palt(0, false)
 palt(14, true)
 init_level(1)
end

function _update()
 move_rowsdower()
end

function _draw()
 cls()
 rectfill(field.minx, field.miny, field.maxx, field.maxy, 3)
 rectfill(0, 121, 128, 128, 0)
 print('fight, rowsdower!', 2, 122, 12)
 spr(0, rowsdower.x, rowsdower.y, 2, 2)
 draw_enemies()
end

__gfx__
eeeee5555555eeeeeeeeeeeeeeeeeeeeeeeee5555555eeee00000000000000000000000000000000000000000000000000000000000000000000000000000000
eeee555ffff55eeeeeeee5555555eeeeeeee555ffff55eee00000000000000000000000000000000000000000000000000000000000000000000000000000000
eee555f7ff7f5eeeeeee555ffff55eeeeee555f1ff1f5eee00000000000000000000000000000000000000000000000000000000000000000000000000000000
eee55ff1ff1f5eeeeee555f1ff1f5eeeeee55ff0ff0f5eee00000000000600000000000000000000000000000000000000000000000000000000000000000000
eee55ffff2fff5eeeee55ff0ff0f5eeeeee55ffff2fff5ee00066666666600000000000000000000000000000000000000000000000000000000000000000000
ee555ffffffff5eeeee55ffff2fff5eeee555ffffffff5ee00000000000000000000000000000000000000000000000000000000000000000000000000000000
eeecccff00ffceeeee555ffffffff5eeeeecccff00ffceee00000000000000000000000000000000000000000000000000000000000000000000000000000000
eecccccc77cccceeeeecccff00ffceeeeecccccc77ccccee00000000000000000000000000000000000000000000000000000000000000000000000000000000
eccccccc77ccccceeecccccc77cccceeeccccccc77ccccce00000000000000000000000000000000000000000000000000000000000000000000000000000000
eccccccc77ccccceeccccccc77ccccceeccccccc77ccccce00000000000000000000000000000000000000000000000000000000000000000000000000000000
ffceeccccccecffeeccccccc77ccccceffceeccccccecffe00000000000000000000000000000000000000000000000000000000000000000000000000000000
ffeeecccecceeffeffceeccccccecffeffeecccceccceffe00000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeecccecceeeeeffeeecccecceeffeeeecccccecccceee00000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeecccecceeeeeeeeeecccecceeeeeeeeccceeeeccc5ee00000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeecccecceeeeeeeeeecccecceeeeeee555ceeeeec55ee00000000000000000000000000000000000000000000000000000000000000000000000000000000
eeee5555e555eeeeeeee5555e555eeeeeeee555eeee55eee00000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeee0000eeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeee000000eeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeee004040eeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeee000000eeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeee000000eeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeee000000eeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeef70000007f6ee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeff77ffff766fee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeff777776666fee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e5ff77666667effe0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e55666666777effe0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ef556660000eeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eff55000000eeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeee50000000eeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeee000ee000eeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eee0000ee0000eee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

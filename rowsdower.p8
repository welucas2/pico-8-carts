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
rowsdower.flip = false

character_speed = 1

enemies = {}
sprite_ref = {}
sprite_ref.c = 32

function init_cultist(x,y)
 cultist = {}
 cultist.type = 'c'
 cultist.x = x
 cultist.y = y
 cultist.flip = false
 cultist.width = 16
 cultist.height = 16
 cultist.health = 20
 return cultist
end

function draw_enemies()
 for i, enemy in pairs(enemies) do
  spr(sprite_ref[enemy.type],enemy.x,enemy.y,2,2,enemy.flip)
 end
end

function move_rowsdower()
 local dx, dy = 0, 0
 if btn(0) then
  dx = -character_speed
 elseif btn(1) then
  dx = character_speed
 elseif btn(2) then
  dy = -character_speed
 elseif btn(3) then
  dy = character_speed
 end
 if dx ~= 0 or dy ~= 0 then
  move_character(rowsdower,dx,dy)
 end
end

function move_enemies()
 for i, enemy in pairs(enemies) do
  local dx = rowsdower.x - enemy.x
  local dy = rowsdower.y - enemy.y
  local drowsdower = sqrt(dx*dx + dy*dy)
  dx = character_speed * dx / drowsdower
  dy = character_speed * dy / drowsdower
  if dx ~= 0 or dy ~= 0 then
    move_character(enemy,dx,dy)
  end
 end
end

function move_character(character, dx, dy)
 character.x += dx
 character.y += dy
 character.x = max(character.x, field.minx)
 character.x = min(character.x, field.maxx-character.width)
 character.y = max(character.y, field.miny)
 character.y = min(character.y, field.maxy-character.height)
 if dx < 0 then
  character.flip=true
 else
  character.flip=false
 end
end

function init_level(level_number)
 if level_number == 1 then
  enemies[1] = init_cultist(100, 100)
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
 move_enemies()
end

function _draw()
 cls()
 rectfill(field.minx, field.miny, field.maxx, field.maxy, 3)
 rectfill(0, 121, 128, 128, 0)
 print('fight, rowsdower!', 2, 122, 12)
 spr(0,rowsdower.x,rowsdower.y,2,2,rowsdower.flip)
 draw_enemies()
end

__gfx__
eeeee5555555eeeeeeeeeeeeeeeeeeeeeeeee5555555eeee00000000000000000000000000000000000000000000000000000000000000000000000000000000
eeee555ffff55eeeeeeee5555555eeeeeeee555ffff55eee00000000000000000000000000000000000000000000000000000000000000000000000000000000
eee555f7ff7f5eeeeeee555ffff55eeeeee555f7ff7f5eee00000000000000000000000000000000000000000000000000000000000000000000000000000000
eee55ff1ff1f5eeeeee555f7ff7f5eeeeee55ff1ff1f5eee00000000000600000000000000000000000000000000000000000000000000000000000000000000
eee55ffff2fff5eeeee55ff1ff1f5eeeeee55ffff2fff5ee00066666666600000000000000000000000000000000000000000000000000000000000000000000
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

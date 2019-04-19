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
rowsdower.facing = 'd'
rowsdower.health = 100
rowsdower.width = 16
rowsdower.height = 16
rowsdower.flip = false

character_speed = 1
ghook_range = 16

enemies = {}
sprite_ref = {}
sprite_ref.c = 32

function init_cultist(x,y)
 cultist = {}
 cultist.type = 'c'
 cultist.x = x
 cultist.y = y
 cultist.distance = 0.001
 cultist.health = 20
 cultist.width = 16
 cultist.height = 16
 cultist.flip = false
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
  rowsdower.facing = 'l'
 elseif btn(1) then
  dx = character_speed
  rowsdower.facing = 'r'
 elseif btn(2) then
  dy = -character_speed
  rowsdower.facing = 'u'
 elseif btn(3) then
  dy = character_speed
  rowsdower.facing = 'd'
 end
 if dx ~= 0 or dy ~= 0 then
  move_character(rowsdower,dx,dy)
 end
end

-- Return a character indicating the direction indicated by the
-- vector (dx, dy).
function calc_direction(dx, dy)
 local angle = atan2(dx, dy)
 if (angle > 0.125 and angle <= 0.375) then
  return 'd'
 elseif (angle > 0.375 and angle <= 0.625) then
  return 'l'
 elseif (angle > 0.625 and angle <= 0.875) then
  return 'u'
 else
  return 'r'
 end
end

function rowsdower_ghook()
 local r_x = rowsdower.x + rowsdower.width / 2
 local r_y = rowsdower.y + rowsdower.height / 2
 for i, enemy in pairs(enemies) do
  if enemy.distance <= ghook_range then
   -- If the enemy's in front of Rowsdower
   local dx = r_x - enemy.x - enemy.width / 2
   local dy = r_y - enemy.y - enemy.height / 2
   if calc_direction(dx,dy) == rowsdower.facing then
     enemy.health -= 2
   end
  end
 end
end

function rowsdower_gun()
end

function rowsdower_attack()
 if btnp(4) then
  rowsdower_ghook()
 elseif btnp(5) then
  rowsdower_gun()
 end
end

--[[ This function moves enemies, and also updates the distance to them.
     The distance is stored as it's needed for combat.]]
function move_enemies()
 for i, enemy in pairs(enemies) do
  local dx = rowsdower.x - enemy.x
  local dy = rowsdower.y - enemy.y
  enemy.distance = sqrt(dx*dx + dy*dy) + 0.001
  dx = character_speed * dx / enemy.distance
  dy = character_speed * dy / enemy.distance
  if dx ~= 0 or dy ~= 0 then
    move_character(enemy,dx,dy)
  end
 end
end

function move_character(character, dx, dy)
 --Move the character then check they're still in bound.
 character.x += dx
 character.y += dy
 character.x = max(character.x, field.minx)
 character.x = min(character.x, field.maxx-character.width)
 character.y = max(character.y, field.miny)
 character.y = min(character.y, field.maxy-character.height)
 --Flip sprite if necessary
 if dx < 0 then
  character.flip=true
 elseif dx > 0 then
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
 rowsdower_attack()
end

function _draw()
 cls()
 rectfill(field.minx, field.miny, field.maxx, field.maxy, 3)
 rectfill(0, 121, 128, 128, 0)
--  print('fight, rowsdower!', 2, 122, 12)
 print('enemy health '..enemies[1].health, 2, 122, 12) 
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

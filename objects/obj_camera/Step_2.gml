//camera_xspeed = abs(sin(clamp(x - obj_player.x,-90,0))) * (30/100)
//camera_yspeed = abs(sin(clamp(y - obj_player.y,-90,0))) * (30/100)
target_x = obj_player.x + (obj_player.current_xspeed*3)
target_y = obj_player.y + (obj_player.yspeed*3)
var dist = clamp(point_distance(x,y,target_x,target_y),0,90)

camera_speed = sin(dist*(pi/180))*4

y += obj_player.yspeed
x += obj_player.current_xspeed

if x > target_x {x -= camera_speed}
if x < target_x {x += camera_speed}

if y < target_y {y += camera_speed}
if y > target_y {y -= camera_speed}

var shake_dir = irandom_range(0,360)

if camera_shake > 0
{
	x += lengthdir_x(camera_shake,shake_dir)
	y += lengthdir_y(camera_shake,shake_dir)
	camera_shake -= 0.5
}

//x = floor(x)
//y = floor(y)

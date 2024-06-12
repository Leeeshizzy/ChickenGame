
//check if on the FLOOR YAY + gravity n shit
if place_meeting(x,y+1,obj_surface)
{
	grounded = 1
	fall_acc = 0
	move_acc = 0.4
}
else
{
	grounded = 0
	fall_acc = 0.2
	move_acc = 0
}




if place_meeting(x,y,obj_bullet)
{
	sprite_index = spr_dummy_hit
	image_speed = 1
	while place_meeting(x,y,obj_bullet)
	{
		var _list = ds_list_create()
		var _num = instance_place_list(x,y,obj_bullet,_list,false)
		var bullet = instance_place(x,y,obj_bullet)
		
		
		current_xspeed += (bullet.xspeed/4)
		yspeed += (bullet.yspeed/-4)
		
		
		instance_destroy(bullet)
		ds_list_destroy(_list)
	}
}

if floor(image_index) = 3
{
	sprite_index = spr_dummy
	image_speed = 0
	image_index = 0
}




yspeed += fall_acc

if current_xspeed > xspeed{current_xspeed -= move_acc}
if current_xspeed < xspeed{current_xspeed += move_acc}

if abs(current_xspeed - xspeed) < move_acc{current_xspeed = xspeed}

//y collision
if yspeed >= 0
{
	if place_meeting(x,y+yspeed,obj_surface)
	{
		if yspeed >= 0
		{
			yspeed = 0
		}
		fall_acc = 0
		y = floor(y)
		while !place_meeting(x,y+1,obj_surface)
		{
			y++
			y = floor(y)
		}
	}
	else
	{
		fall_acc = 0.2
	}
}
else
{
	if place_meeting(x,y+yspeed,obj_surface)
	{
		yspeed = 0
		y = ceil(y)
		while !place_meeting(x,y-1,obj_surface)
		{
			y--
			y = ceil(y)
		}
	}
}




//x collision
if place_meeting(x+current_xspeed,y,obj_surface)
{
	if !place_meeting(x+current_xspeed,y-abs(current_xspeed)-1,obj_surface)
	{
		while place_meeting(x+current_xspeed,y,obj_surface)
		{
			y -= 0.5
		}
	}
	else
	{
		while !place_meeting(x+sign(current_xspeed),y,obj_surface)
		{
			x += sign(current_xspeed)
			
			if current_xspeed > 0 {x = floor(x)}
			if current_xspeed < 0 {x = ceil(x)}
		}
		current_xspeed = 0
		xspeed = 0
	}
}

x += current_xspeed
y += yspeed

if mouse_check_button_pressed(mb_right) && position_meeting(mouse_x,mouse_y,id)
{
	grabbed = 1
}


if grabbed = 1
{
	current_xspeed = 0
	yspeed = 0
	x = mouse_x
	y = mouse_y
	sprite_index = spr_dummy_wriggle
	image_speed = 1
}
else
{
	
}

if mouse_check_button_released(mb_right)
{
	grabbed = 0
	current_xspeed = (x - xprevious)/3
	yspeed = (y- yprevious)/3
}
x += current_xspeed
y += yspeed

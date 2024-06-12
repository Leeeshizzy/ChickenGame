//mouse location pl;ayer facing left or right?????????
// running
if grounded
{
	if xspeed != 0
	{
		movetime++
	}
	else
	{
		movetime = 0
	}
}
/*
if movetime = 1
{
	image_index = 1
	if grounded
	{
		var _footstep_number = irandom_range(1,4)
		audio_play_sound(footstep_sound[_footstep_number],8,false)
	}
}
*/
//shaking for some reason
if keyboard_check_pressed(ord("E")){shake += 1}
if keyboard_check_pressed(ord("Q")){shake -= 2}
var shake_xoffset = 0
var shake_yoffset = 0
var dir = irandom_range(0,360)
if shake > 0
{
	shake_xoffset += irandom_range(0,lengthdir_x(shake,dir))
	shake_yoffset += irandom_range(0,lengthdir_y(shake,dir))
}
if grounded
{
	shake_yoffset = 0
	shake_xoffset += shake*flicker
}
//draw sprites 
var i = 1
if gun_angle > 90 && gun_angle < 270
{
	i = -1
}
if firetimer < 15 && state != playerstate.walljump
{
	i_xscale = i
}

draw_sprite_ext(sprite_index,image_index,x+shake_xoffset,y+shake_yoffset,i_xscale,image_yscale,0,c_white,1)
if weapon_equipped == weapon.shotgun
{
	if state != playerstate.sliding && state != playerstate.crawling && state != playerstate.walljump
	{
		if firetimer < 15
		{
			draw_sprite_ext(shotgun_sprite,firetimer,x+shake_xoffset,y-3+shake_yoffset,1,i,gun_angle,c_white,1)
		}
		else
		{
			var i = 0
			if sprite_index = spr_player_walk_gun
			{
				if floor(image_index) == 1 || floor(image_index) == 3
				{
					i=1
				}
			}
			//draw_sprite_ext(spr_shotgun,0,x+shake_xoffset,y-3+shake_yoffset,1,i_xscale,point_direction(x,y-3,mouse_x,mouse_y),c_white,1)
			
			draw_sprite_ext(shotgun_sprite,0,x+shake_xoffset,y-3+shake_yoffset-i,i_xscale,1,0,c_white,1)
		}
	}
}
else
{
	switch(sprite_index)
	{
		case spr_player:
		draw_sprite_ext(spr_player_arm,image_index,x,y,i_xscale,image_yscale,0,c_white,1)
		break
	}
}
//arms
switch(sprite_index)
{
	case spr_player:
	draw_sprite_ext(spr_player_arm,image_index,x+shake_xoffset,y+shake_yoffset,i_xscale,image_yscale,0,c_white,1)
	break
	case spr_player_fired:
	draw_sprite_ext(spr_player_fired_arm,image_index,x+shake_xoffset,y+shake_yoffset,i_xscale,image_yscale,0,c_white,1)
	break
	case spr_player_walk_gun:
	draw_sprite_ext(spr_player_walk_gun_arm,image_index,x+shake_xoffset,y+shake_yoffset,i_xscale,image_yscale,0,c_white,1)
	break
}


//UI
switch(weapon_equipped)
{
	case weapon.shotgun:
	//bullet ui
	draw_sprite(spr_bullets_ui,ammo,x,y-18)
	draw_sprite(spr_bullets_ui,ammo,x,y-18)
	reloaduimulti = reloadmaxtime/15
	//draw_sprite_part(spr_reload_ui,0,0,0,15-(reloadtime/reloaduimulti),1,x-7.5,y-14)
	break
}

//health
draw_sprite(spr_health_bg_ui,0,x,y-22)
draw_sprite_part(spr_health_ui,0,0,0,ceil(hp/5),4,x-10,y-24)



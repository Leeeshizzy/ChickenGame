//controls
leftkey = keyboard_check(ord("A"))
rightkey = keyboard_check(ord("D"))
jumpkey = keyboard_check_pressed(vk_space)
leftclick = mouse_check_button_pressed(mb_left)
rightclick = mouse_check_button_pressed(mb_right)
shiftkey = keyboard_check(vk_shift)

shootcd--
//check if on the FLOOR YAY + gravity n shit
if place_meeting(x,y+1,obj_surface)
{
	grounded = 1
	groundtime++
	airtime = 0
	fall_acc = 0
	airshots = 0
}
else
{
	grounded = 0
	groundtime = 0
	airtime++
	fall_acc = 0.2
}
//idk mask stuff
if xspeed != 0
{
	image_xscale = sign(xspeed)
}
/*
if mouse_x > x
{
	image_xscale = 1
}
else
{
	image_xscale = -1
}
*/
mask_index = spr_player


//hi


// movement calculations
//gravity
yspeed += fall_acc
if jump > 0{jump--}
// STATES MACHINE LETS FUCKING GO
switch(state)
{
	//normal state like walking n stuff
	case playerstate.normal:
	xspeed = (rightkey - leftkey)*movespeed
	if jumpkey{jump = 6}
	// default state of being on ground and stuff pretty cool
	if grounded
	{
		sprite_index = spr_player
		
		if yspeed >= 0
		{
			if abs(current_xspeed - xspeed) > 1.7 {move_acc = 0.4}else{move_acc = 0.25}
			yspeed = 0
		}
		if jump >= 1
		{
			yspeed = -3
			if abs(current_xspeed) > 1.4
			{
				audio_play_sound(snd_skid,8,false)
			}
			else
			{
				audio_play_sound(snd_footstep2,8,false)
			}
		}

		if current_xspeed != 0
		{
			switch(weapon_equipped)
			{
				case weapon.shotgun:
				sprite_index = spr_player_walk_gun
				break
				default:
				sprite_index = spr_player_walk
				break
			}
			
			
			
			if keyboard_check_released(ord("A")) || keyboard_check_released(ord("D"))
			{
				audio_play_sound(snd_skid,8,false)
			}
			
			if floor(image_index*8)/8 == 0 || floor(image_index*8)/8 == 2
			{
				var _footstep_number = irandom_range(1,4)
				audio_play_sound(footstep_sound[_footstep_number],8,false)
			}
			
			/*
			if image_index == 1 || image_index == 3
			{
				var _footstep_number = irandom_range(1,4)
				audio_play_sound(footstep_sound[_footstep_number],8,false)
			}
			*/
			if shiftkey && abs(current_xspeed) > movespeed
			{
				audio_play_sound(snd_slide,8,true)
				jump = 0
				state = playerstate.sliding
			}
		}
		if groundtime == 2
		{
			audio_play_sound(snd_footstep3,8,false)
		}
	}
	else // when you like jump or fall off something ig
	{
		state = playerstate.airborne
	}
	break 
	
	
	case playerstate.airborne:
	sprite_index = spr_player_jump
	
	xspeed = (rightkey - leftkey)*movespeed
	if jumpkey{jump = 6}
	
	move_acc = 0.1
	if yspeed < 0 
	{
		if keyboard_check_released(vk_space)
		{
			yspeed /= 2
		}
	}
	if grounded
	{
		if shiftkey && abs(current_xspeed) > movespeed
		{
			audio_play_sound(snd_slide,8,true)
			state = playerstate.sliding
		}
		else
		{
			state = playerstate.normal
		}
	}
	break


	case playerstate.sliding:
	
	switch(weapon_equipped)
	{
		case weapon.shotgun:
		sprite_index = spr_player_slide_gun
		break
		default:
		sprite_index = spr_player_slide
		break
	}
	
	mask_index = spr_player_slide
	if current_xspeed != 0 {image_xscale = sign(current_xspeed)}
	firetimer = 60
	if jumpkey{jump = 6}

	//yspeed = clamp(yspeed, 0, infinity)
	xspeed = 0
	move_acc = 0.05
	/* slide falling sprite ignition
	if weapon_equipped == weapon.shotgun
	{
		sprite_index = spr_player_slide_fall
	}
	*/
	if groundtime = 0
	{
		audio_stop_sound(snd_slide)
	}
	if groundtime = 1
	{
		audio_play_sound(snd_slide,8,true)
		if !shiftkey
		{
			audio_stop_sound(snd_slide)
			state = playerstate.normal
		}
	}
	audio_sound_gain(snd_slide,(abs(current_xspeed)/15),0)
	
	if !place_meeting(x,y-3,obj_surface)
	{
		if jump > 0
		{
			yspeed = -3 - (abs(current_xspeed)/4)
			current_xspeed += sign(current_xspeed)*1.5
			audio_stop_sound(snd_slide)
			audio_play_sound(snd_skid,8,false)
			state = playerstate.airborne
		}
		if abs(current_xspeed) <= movespeed
		{
			audio_stop_sound(snd_slide)
			state = playerstate.normal
		}
	}
	else
	{
		if abs(current_xspeed) <= 3
		{
			audio_stop_sound(snd_slide)
			state = playerstate.crawling
		}
	}
	break
	
	
	
	
	case playerstate.crawling:
	mask_index = spr_player_slide
	
	xspeed = 0
	var i = (rightkey - leftkey)*2
	move_acc = 0.1
	if i != 0
	{
		sprite_index = spr_player_crawl
		image_xscale = sign(i)
		if floor(image_index*8)/8 == 1 || floor(image_index*8)/8 == 3
		{
			current_xspeed = i
		}
	}
	else
	{
		sprite_index = spr_player_crouch
		move_acc = 1
	}
	
	if !place_meeting(x,y-3,obj_surface)
	{
		state = playerstate.normal
	}
	break

	//when you shoot muahahahahahahahahhaa
	case playerstate.fired:
	sprite_index = spr_player_fired
	xspeed = rightkey - leftkey
	firetimer = 13
	
	if current_xspeed != 0
	{
		image_xscale = -sign(current_xspeed)
		
	}
	if sign(xspeed) == sign(current_xspeed)
	{
		if abs(current_xspeed) >= abs(xspeed)
		{	
			move_acc = 0.0
		}
	}
	else
	{
		move_acc = 0.1
	}
	if grounded{state = playerstate.normal}
	break
}

// WEAPONS WHY DIDNT I LABEL THIS EARLIER
firetimer++
switch(weapon_equipped)
{
	case weapon.shotgun:
	/*reloading
	if !grounded
	{
		reloadmaxtime = 30
	}
	else
	{
		reloadmaxtime = 15
	}
	if groundtime = 1
	{
		reloadtime /= 2
	}
	if airtime = 1
	{
		reloadtime *= 2
	}
	if state != playerstate.crawling
	{
		if rightclick && ammo < 3
		{
			reloading = 1
		}	
		
		if reloading
		{
			reloadtime --
			if reloadtime <= 0
			{
				ammo++ 
				reloadtime = reloadmaxtime
			}
			if ammo >= 3 || shootcd == 20
			{
				reloading = 0
			}
		}
		else
		{
			reloadtime = reloadmaxtime
		}
	}
	*/
	
	//floor reload
	if groundtime = 1 && ammo < 3
	{
		ammo = 3
		audio_play_sound(snd_reload,8,false)
		reloading = 1
	}
	
	if reloading = 1
	{
		reloadtime --
		shotgun_sprite = spr_shotgun_rack
		if reloadtime <= 0
		{
			reloading = 0
		}
	}
	else
	{
		reloadtime = 10
		shotgun_sprite = spr_shotgun
	}
	
	
	
	
	
	
	if state != playerstate.sliding && state != playerstate.crawling
	{
		//gun shoot
		
		
		//mouse shit and player fling positioning
		if shootcd < 0
		{
			if leftclick
			{
				if ammo > 0
				{
					gun_angle = point_direction(x,y-3,mouse_x,mouse_y)
					var _pellet_count = 0
					var _pellet_number = 7
					var h = 0
		
					repeat(_pellet_number)
					{
					spread_range[_pellet_count] = irandom_range(-30,30)
					_pellet_count++
					}
					repeat(irandom_range(5,6))
					{
						with instance_create_layer(x,y-5,"Instances",obj_bullet)
						{
							spread_range = other.spread_range[h]
							h++
						}
					}
					//recoil THE RIGHT WAY WHY DIDNT I DO THIS SOONER
					var recoilx = x
					var recoily = y
					var recoildir = point_direction(x,y,mouse_x,mouse_y)
					recoilx += 7 * cos((recoildir)*(pi/180))
					recoily -= 7 * sin((recoildir)*(pi/180))
					yspeed /= 2
					//current_xspeed /= 2
					current_xspeed -= recoilx-x
					yspeed -= recoily-y
					obj_camera.camera_shake = 5
					ammo--
					audio_play_sound(snd_shotgun,8,false)
					fired = 1
					
					if !place_meeting(x,y+yspeed,obj_surface){state = playerstate.fired} else{state = playerstate.normal}
					firetimer = 0
					shootcd = 20
					reloading = 0
					if !grounded{airshots++}
				}
			}
		}
	}
	break
	
	case weapon.bbbat:
	
	
	
	
	break
}




//floor clip up if in ground and down if in ceiling
if place_meeting(x,y,obj_surface)
{
	while(place_meeting(x,y,obj_surface))
	{
		if yspeed >= 0
		{
			y--
		}
		else
		{
			y++
		}
	}
}
//floor and ceiling collision
if yspeed >= 0
{
	if place_meeting(x,y+yspeed,obj_surface)
	{
		if yspeed >= 0
		{
			fall_acc = 0
			yspeed = 0
		}
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

//movement again ig
if grounded
{
	if abs(current_xspeed - xspeed) > 5.1
	{
		move_acc = 0.4
	}
}
if current_xspeed > xspeed{current_xspeed -= move_acc}
if current_xspeed < xspeed{current_xspeed += move_acc}

if abs(current_xspeed - xspeed) < move_acc{current_xspeed = xspeed}

//walls 
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
			x += sign(current_xspeed)/2
			if current_xspeed > 0 {x = floor(x)}
			if current_xspeed < 0 {x = ceil(x)}
		}
		xspeed = 0
		current_xspeed = 0
	}
}

if yspeed >= 0 && !place_meeting(x+current_xspeed,y+1,obj_surface) && place_meeting(x+current_xspeed,y+abs(current_xspeed)+1,obj_surface)
{
	while !place_meeting(x+current_xspeed,y+1,obj_surface)
	{
		y += 1
	}
}






//movement execution
//yspeed = clamp(yspeed,-18,18)
//current_xspeed = clamp(current_xspeed,-18,18)
x += current_xspeed
y += yspeed

//camera stuff
//obj_camera.x = x
//obj_camera.y = y


if keyboard_check_pressed(vk_f4)
{
	if fullscreen = 0
	{
		fullscreen = 1
	}
	else
	{
		fullscreen = 0
	}
}
window_set_fullscreen(fullscreen)
if keyboard_check_pressed(ord("R"))
{
	xspeed = 0
	yspeed = 0
	current_xspeed = 0
	x = 777
	y= 940
	obj_camera.x = x
	obj_camera.y = y
}
if keyboard_check_pressed(ord("M"))
{
	if mute == 1
	{
		mute = 0
	}
	else
	{
		mute = 1
	}
}
audio_sound_gain(mus_test,mute,0)
if keyboard_check_pressed(ord("G"))
{
	if weapon_equipped == weapon.shotgun
	{
		weapon_equipped = weapon.bbbat
	}
	else
	{
		weapon_equipped = weapon.shotgun
	}
}

if keyboard_check_pressed(ord("F"))
{
	obj_camera.camera_shake = 12
}
if keyboard_check_pressed(vk_escape)
{
	game_end()
}
if keyboard_check(ord("K")){hp++}
if keyboard_check(ord("J")){hp--}

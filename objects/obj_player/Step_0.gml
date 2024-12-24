//controls
leftkey = keyboard_check(ord("A"))
rightkey = keyboard_check(ord("D"))
jumpkey = keyboard_check_pressed(vk_space)
leftclick = mouse_check_button_pressed(mb_left)
rightclick = mouse_check_button_pressed(mb_right)
shiftkey = keyboard_check(vk_shift)



if global.hitstop <= 0
{

	shootcd--

	//flicker...

	flicker *= -1


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


	/*
	if mouse_x > x
	{
		i_xscale = 1
	}
	else
	{
		i_xscale = -1
	}
	*/

	mask_index = spr_player

	//hi


	// movement calculations
	//jumping
	if jump > 0{jump--}
	if jumpkey{jump = 6}
	// STATES MACHINE LETS FUCKING GO ( i think?????)
	switch(state)
	{
		//normal state like walking n stuff p cool
		case playerstate.normal:
		
	
		
			xspeed = (rightkey - leftkey)*movespeed
	
		
		
		
		
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
				yspeed = -3.5
				if abs(current_xspeed) > 1.4
				{
					
					audio_play_sound(snd_skid,8,false)
				}
				else
				{
					audio_play_sound(snd_slidethud,8,false)
				}
			}

			if current_xspeed != 0
			{
				movetime ++
			
			
			//momentum (????????????)
				if weapon_equipped != weapon.shotgun
				{
					if movetime = 2{movespeed = abs(current_xspeed)}
					movespeed += 0.015
					movespeed = clamp(movespeed,1.5,3)
					image_speed = (abs(current_xspeed/1.5)-1/3)
					image_speed = clamp(image_speed,1,1.7)
					//image_speed += 0.01
					//image_speed = clamp(image_speed,1,2)
				}
				else
				{
					movespeed = 1.5
					image_speed = 1
				}
			
				switch(weapon_equipped)
				{
					case weapon.shotgun:
					sprite_index = spr_player_walk_gun
					break
					case weapon.unarmed:
					if movespeed >= 2.75
					{
						sprite_index = spr_player_run
					}
					else
					{
						sprite_index = spr_player_walk
					}
					break
				}
			
			
				if keyboard_check_released(ord("A")) || keyboard_check_released(ord("D"))
				{
					audio_play_sound(snd_skid,8,false)
					movespeed = 1.5
					image_speed = 1
				}
			
				if floor(image_index) == 0 || floor(image_index) == 2
				{
					footsteps_time++
				}
				else
				{
					footsteps_time = 0
				}
			
				if footsteps_time == 1//floor(image_index*8)/8 == 0 || floor(image_index*8)/8 == 2
				{
					
					
					var _footstep_number = irandom_range(1,4)
					
					if _footstep_number = nore
					{
						_footstep_number = irandom_range(1,3)
					}
					if _footstep_number = nore
					{
						_footstep_number++
					}
					
					var pitchshift = irandom_range(-10,10)/50
					
					
					
					
					audio_play_sound(footstep_sound[_footstep_number],8,false,1,0,pitchshift+1)
					
					
					
					
					
					nore = _footstep_number
					
					
				}
			
				/*
				if image_index == 1 || image_index == 3
				{
					var _footstep_number = irandom_range(1,4)
					audio_play_sound(footstep_sound[_footstep_number],8,false)
				}
				*/
				if shiftkey
				{
					if abs(current_xspeed) >= 2.75
					{
						audio_play_sound(snd_slide,8,true)
						audio_play_sound(snd_slidethud,8,false)
						jump = 0
						state = playerstate.sliding
					}
				}
			}
			else
			{
				movetime = 0
				movespeed = 1.5
				image_speed = 1
			}
		
		
		
			if groundtime == 2
			{
				audio_play_sound(snd_slidethud,8,false)
			}
		}
		else // when you like jump or fall off something ig
		{
			state = playerstate.airborne
		}
		break 
	
	
		case playerstate.airborne:
		
		if yspeed <= -1
		{
			sprite_index = spr_player_jump
		}
		else
		{
			sprite_index = spr_player_fall
		}
		xspeed = (rightkey - leftkey)*movespeed
	
	
		
	
		if abs(current_xspeed) > 3
		{
			
			if sign(xspeed) == -sign(current_xspeed)
			{
				move_acc = 0.1
			}
			else
			{
				move_acc = 0
			}
		}
		else
		{
			if sign(xspeed) == sign(current_xspeed) && abs(current_xspeed) > 1.5
			{
				move_acc = 0
			}
			else
			{
				move_acc = 0.1
			}
		}
		
		if yspeed < 0 
		{
			if keyboard_check_released(vk_space)
			{
				yspeed /= 2
			}
		}

		//flipping
		if weapon_equipped = weapon.unarmed 
		{
			if leftclick
			{
				yspeed = -2
				current_xspeed += sign(xspeed)*2
				state = playerstate.flipping
			}
		}
		//walljump
		
		if place_meeting(x+1,y,obj_surface) 
		{
			state = playerstate.walljump
			i_xscale = 1
		}
		if place_meeting(x-1,y,obj_surface) 
		{
			state = playerstate.walljump
			i_xscale = -1
		}

		//floor hit chuckle chuickel hahahah hahaa......
		if grounded{state = playerstate.normal}
		break
	
	
		case playerstate.flipping:
		sprite_index = spr_player_roll//safe//NOT SAGE
		xspeed = (rightkey - leftkey)*movespeed
		firetimer = 13
	
	
		if sign(xspeed) == sign(current_xspeed)
		{
			if abs(current_xspeed) >= abs(xspeed)
			{	
				move_acc = 0.0//safe?
			}
		}
		else
		{
			move_acc = 0.1
		}
	
		if place_meeting(x+1,y,obj_surface) 
		{
			state = playerstate.walljump
			i_xscale = 1
		}
		if place_meeting(x-1,y,obj_surface) 
		{
			state = playerstate.walljump
			i_xscale = -1
		}
	
	
		//floor hit chuckle chuickel hahahah hahaa......
		if grounded{state = playerstate.normal}
		break

	//when you shoot muahahahahahahahahhaa abnd also airborne
		case playerstate.fired:
		sprite_index = spr_player_fired//safe
		xspeed = (rightkey - leftkey)*movespeed
		firetimer = 13
	
	
		if current_xspeed != 0
		{
			//i_xscale = -sign(current_xspeed)//not safe dont work
		}
		if sign(xspeed) == sign(current_xspeed)
		{
			if abs(current_xspeed) >= abs(xspeed)
			{	
				move_acc = 0.0//safe?
			}
		}
		else
		{
			move_acc = 0.1
		}
	
		if place_meeting(x+1,y,obj_surface) 
		{
			state = playerstate.walljump
			i_xscale = 1
		}
		if place_meeting(x-1,y,obj_surface) 
		{
			state = playerstate.walljump
			i_xscale = -1
		}
	
	
		//floor hit chuckle chuickel hahahah hahaa......
		if grounded{state = playerstate.normal}
		break


		case playerstate.walljump:
		//walljumping
	
		//yspeed = clamp(yspeed,-infinity,2)
		if yspeed > 2 {yspeed -= 0.5}
		fallspeed = 0.1
		xspeed = 0
		var i = rightkey - leftkey
		if jumpkey
		{
			if jump > 0
			{
				yspeed = -4
				current_xspeed = -i_xscale*3 + i
				//i_xscale *= -1
				state = playerstate.airborne
			}
		}
		sprite_index = spr_player_walljump
		if grounded{state = playerstate.normal}
	
		if !place_meeting(x+i_xscale,y,obj_surface)
		{
			state = playerstate.airborne
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
		if current_xspeed != 0 {i_xscale = sign(current_xspeed)}
		firetimer = 60


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
			if !shiftkey
			{
				audio_stop_sound(snd_slide)
				state = playerstate.normal
			}
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
	
		if yspeed < 0
		{
			state = playerstate.airborne
		}
		if !place_meeting(x,y-3,obj_surface)
		{
			if jump > 0 && grounded
			{
				yspeed = -3 - (abs(current_xspeed)/4)
				//current_xspeed += sign(current_xspeed)*1.5
				audio_stop_sound(snd_slide)
				audio_play_sound(snd_skid,8,false)
				state = playerstate.airborne
			}
			if abs(current_xspeed) <= 0.6
			{
				audio_stop_sound(snd_slide)
				state = playerstate.normal
			}
		}
		else
		{
			if abs(current_xspeed) <= 1
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
			i_xscale = sign(i)
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

	}

	//movement again ig


	if current_xspeed > xspeed{current_xspeed -= move_acc}
	if current_xspeed < xspeed{current_xspeed += move_acc}

	if abs(current_xspeed - xspeed) < move_acc{current_xspeed = xspeed}

	yspeed += fall_acc

	if state != playerstate.normal
	{
		movespeed = 1.5
		image_speed = 1
		movetime = 0
	}



	//idk mask stuff
	if xspeed != 0 && state != playerstate.walljump
	{
		i_xscale = sign(xspeed)
	}
	
	
	//grappling hook YAY!!!!!!!!!!!!!!!!!!!!!!!!!!!! no ones ever made a grtappling hook bef
	
	if rightclick
	{
		if hookstate == "undeployed"
		{
			hookx = x
			hooky = y-7
			hookstate = "airborne"
			var _hooklaunchspeed = 8
			var _hookxdir = dcos(point_direction(x,y,mouse_x,mouse_y))
			var _hookydir = -dsin(point_direction(x,y,mouse_x,mouse_y))
			hookout = true
			hookxspeed = /*current_xspeed + */(_hookxdir*_hooklaunchspeed)
			hookyspeed = /*yspeed + */(_hookydir*_hooklaunchspeed)
		}
		else
		{
			
			if hookstate != "latched"
			{
				hookstate = "retracting"
			}
		}
		/*
		if !instance_exists(obj_hook)
		{
			var _hooklaunchspeed = 6
			var _hookxdir = dcos(point_direction(x,y,mouse_x,mouse_y))
			var _hookydir = -dsin(point_direction(x,y,mouse_x,mouse_y))
			
			
			with instance_create_depth(x,y-7,depth+1,obj_hook)
			{
				xspeed = other.current_xspeed+(_hookxdir*_hooklaunchspeed)
				yspeed = other.yspeed+(_hookydir*_hooklaunchspeed)	
			}
		}
		*/
	}

	switch hookstate
	{
		case "airborne":
			
		hookyspeed += 0.2
		
		for (var i = 0; i < 50; i++;)
		{
			hookx += hookxspeed 
			hooky += hookyspeed
			
			if position_meeting(hookx,hooky,obj_surface)
			{
				i = 50	
			}
			
		}
		if !position_meeting(hookx,hooky,obj_surface)
		{
			hookstate = "undeployed"
		}
		
		
		
		if position_meeting(hookx,hooky,obj_surface)
		{
			hookxspeed = 0
			hookyspeed = 0
			//hookstate = "latched"
			hookstate = "pulling"
			if point_distance(hookx,hooky,x,y) >= 250
			{
				//hookstate = "retracting"
			}
		}
		break
			
		case "latched":
		if rightclick
		{
			hookstate = "pulling"
		}
		
		if point_distance(hookx,hooky,x,y) >= 250
		{
			hookstate = "retracting"
		}
		
		
		break
			
		//pulling is pulling the player
		case "pulling":
		var pulldirx = dcos(point_direction(x,y,hookx,hooky))
		var pulldiry = dsin(point_direction(x,y,hookx,hooky))
		current_xspeed += pulldirx*0.5
		yspeed -= pulldiry*0.5
		
		
		if !mouse_check_button(mb_right)
		{
			hookstate = "undeployed"
		}
		break	
		//retracting is when the hook is not attached to anything when pulled
		case "retracting":
		retracttime++
		var pulldirx = dcos(point_direction(hookx,hooky,x,y))
		var pulldiry = dsin(point_direction(hookx,hooky,x,y))
		hookx += pulldirx*20
		hooky -= pulldiry*20
		hookxspeed = 0
		hookyspeed = 0
		if point_distance(x,y,hookx,hooky) <= 30 || retracttime > 60
		{
			hookstate = "undeployed"
			retracttime = 0
		}
		break
	}
	hookx += hookxspeed 
	hooky += hookyspeed

	// WEAPONS WHY DIDNT I LABEL THIS EARLIER
	firetimer++
	switch(weapon_equipped)
	{
		case weapon.shotgun:
		//floor reload
		if grounded = 1 && ammo < 3 && reloading == 0
		{
			//audio_play_sound(snd_reload,8,false)
			reloading = 1
		}
	
		if reloading = 1
		{
			reloadtime --
			shotgun_sprite = spr_shotgun_rack
			if reloadtime <= 0
			{
				reloading = 0
				ammo = 3
			}
		}
		else
		{
			reloadtime = 10
			shotgun_sprite = spr_shotgun
		}
	
	
	
	
	
	
		if state != playerstate.sliding && state != playerstate.crawling && state != playerstate.walljump
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
						var _pellet_number = 15//idk like 15
						var h = 0
						repeat(_pellet_number)
						{
						spread_range[_pellet_count] = random_range(-15,15) //20
						_pellet_count++
						}
						repeat(irandom_range(_pellet_number-(ceil(_pellet_number/5)),_pellet_number))
						{
							var _speed = random_range(9-(abs(spread_range[h])/5),15-(abs(spread_range[h])/5))+3// 7/11

						
							with instance_create_layer(x,y-3,"Instances",obj_bullet)
							{
								spread_range = other.spread_range[h]
								spd = _speed
								h++
							}
						}
						//recoil THE RIGHT WAY WHY DIDNT I DO THIS SOONER
						var recoilx = x
						var recoily = y
						var recoildir = point_direction(x,y,mouse_x,mouse_y)
						
						var recoilxdir = dcos(recoildir)*recoilstrength
						var recoilydir = dsin(recoildir)*recoilstrength
						
						
						recoilx += 7 * cos((recoildir)*(pi/180))
						recoily -= 7 * sin((recoildir)*(pi/180))
						
						
						yspeed /= 2
						//recoil YAYYYYYAYYAYAYAYA YAYAYYA FUCK YEAH WOIOHOOOOOOOOOOOOO
						current_xspeed -= recoilxdir
						yspeed += recoilydir
						//current_xspeed -= recoilx-x
						//yspeed -= recoily-y
					//wtf is this goofy ass code
						obj_camera.camera_shake = 3
						ammo--
						audio_play_sound(snd_shotgun,8,false)
						//fired = 1
						
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
			jump = 0
			while !place_meeting(x,y-1,obj_surface)
			{
				y--
				y = ceil(y)
			}
		}
	}

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
				x += sign(current_xspeed)
			
				if current_xspeed > 0 {x = floor(x)}
				if current_xspeed < 0 {x = ceil(x)}
			}
			xspeed = 0
			current_xspeed = 0
		}
	}

	if yspeed >= 0 && !place_meeting(x+current_xspeed,y+1,obj_surface) && place_meeting(x+current_xspeed,y+clamp(abs(current_xspeed),0,3)+2,obj_surface)
	{	
		while !place_meeting(x+current_xspeed,y+1,obj_surface)
		{
			y += 0.5
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
		y = 840
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
	audio_sound_gain(mus_test2,mute,0)
	if keyboard_check_pressed(ord("G"))
	{
		if weapon_equipped == weapon.shotgun
		{
			weapon_equipped = weapon.unarmed
		}
		else
		{
			weapon_equipped = weapon.shotgun
		}
	}

	if keyboard_check_pressed(ord("F"))
	{
		global.hitstop = 12
	}
	if keyboard_check_pressed(vk_escape)
	{
		game_end()
	}

	if mouse_check_button_pressed(mb_middle)
	{
		instance_create_layer(mouse_x,mouse_y,"Instances",obj_dummy)
	}
	if keyboard_check(ord("K")){hp++}
	if keyboard_check(ord("J")){hp--}
}
else
{
	global.hitstop --
	image_speed = 0
}

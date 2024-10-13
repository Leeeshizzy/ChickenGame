age++
switch state
{
	
	
	case "latched":
	{
		if mouse_check_button_pressed(mb_right)// && age >= 1
		{
			state = "pulling"
		}
	}
	break
	case "airborne":
	{
		yspeed += 0.2
		if place_meeting(x,y,obj_surface)
		{
			xspeed = 0
			yspeed = 0
			state = "latched"
		}

	}
	break
	
	case "pulling":
	{
		var p = obj_player
		var pulldirx = dcos(point_direction(p.x,p.y,x,y))
		var pulldiry = dsin(point_direction(p.x,p.y,x,y))
		
		p.current_xspeed += pulldirx/2
		p.yspeed -= pulldiry/2
		
		if distance_to_object(obj_player) < 25
		{
			instance_destroy()
		}
	}
	break
}


var p = obj_player
image_angle = point_direction(x,y,p.x,p.y) +90


x+=xspeed
y+=yspeed




if distance_to_object(obj_player) > 250 
{
	instance_destroy()
}



	if (lifetime < max_lifetime/* - abs(spread_range/6 )*/)
	{
		xspeed = (spd * cos((dir+spread_range)*(pi/180)))
		yspeed = (spd * sin((dir+spread_range)*(pi/180)))
		x += xspeed
		y -= yspeed
		if place_meeting(x,y,obj_surface)
		{
			instance_destroy()
		}
		lifetime += 0.5
		image_alpha -= 0
	}
	else
	{
		instance_destroy(id)
	}
	var hypotenuse = sqrt(abs(sqr((spd * cos(dir*(pi/180)))*length) + sqr((spd * sin(dir*(pi/180)))*length)))
//trail
trail_x[trail_number] = x
trail_y[trail_number] = y

if trail_number >= 1
{
	draw_line_width_color(trail_x[trail_number],trail_y[trail_number],trail_x[trail_number-1],trail_y[trail_number-1],1,c_yellow,c_yellow)
}
trail_number++

depth = -90000
draw_text(camera_get_view_x(view_camera[0])+3,camera_get_view_y(view_camera[0])+3,"("+string(floor(obj_player.x))+","+string(floor(obj_player.y))+")")

draw_text(obj_player.x-12,obj_player.y-80,obj_player.current_xspeed)

draw_text(obj_player.x-12,obj_player.y-100,fps)


//abs(obj_player.current_xspeed - obj_player.xspeed)


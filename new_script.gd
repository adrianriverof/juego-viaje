extends Node


func move():
	
	
	x_direction = int(Input.is_action_pressed("p1")) - int(Input.is_action_pressed("move_left_1"))
	y_direction = int(Input.is_action_pressed("move_down_1")) - int(Input.is_action_pressed("move_up_1"))
	
	if x_direction != 0 && y_direction != 0:  #diagonal speed
		speed = current_speed * sqrt(2)/2
	else:
		speed = current_speed
	
	velocity.x = lerp(velocity.x, x_direction * speed, 0.2)
	velocity.y = lerp(velocity.y, y_direction * speed, 0.2)
	
	move_and_slide(velocity)

extends KinematicBody2D


var giro_input = 0



func set_physics_process(delta):
	move()


func move():
	#acceleration()
	giro()
	
func giro():
	giro_inputs()
	
	


func giro_inputs():
	giro_input = int(Input.is_action_pressed("p1right")) - int(Input.is_action_pressed("p1left"))
	






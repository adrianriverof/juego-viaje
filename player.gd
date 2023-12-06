extends KinematicBody2D


var cantidad_giro = 0



func _physics_process(delta):
	move()
	


func move():
	#acceleration()
	giro()
	
func giro():
	giro_inputs()
	rotar_todo()
	
	
func rotar_todo():
	rotation += cantidad_giro * 0.5/(2 * PI)
	
	


func giro_inputs():
	cantidad_giro = int(Input.is_action_pressed("p1right")) - int(Input.is_action_pressed("p1left"))
	#print(cantidad_giro)






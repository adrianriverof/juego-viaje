extends KinematicBody2D


var cantidad_giro = 0 
var cantidad_avance = 0 

var velocity  = Vector2.ZERO

var speed = 500

func _physics_process(delta):
	move()
	


func move():
	#acceleration()
	
	avance()
	giro()
	
	
func avance():
	avance_inputs()
	
	
	
	velocity.x = lerp(velocity.x, cantidad_avance * speed * cos(rotation), 0.2)
	velocity.y = lerp(velocity.y, cantidad_avance * speed * sin(rotation), 0.2)
	
	move_and_slide(velocity)

	

func avance_inputs():
	cantidad_avance = int(Input.is_action_pressed("p1up")) - int(Input.is_action_pressed("p1down"))


func giro():
	giro_inputs()
	rotar_todo()
	
	
func rotar_todo():
	rotation += cantidad_giro * 0.5/(2 * PI)

func giro_inputs():
	cantidad_giro = int(Input.is_action_pressed("p1right")) - int(Input.is_action_pressed("p1left"))
	#print(cantidad_giro)






extends KinematicBody2D


var cantidad_giro = 0 
var cantidad_avance = 0 

var velocity  = Vector2.ZERO

var rotation_radians = 0.5
var speed = 500
var move_weight = 0.05


func _physics_process(delta):
	move()
	






func move():	
	avance()
	giro()


func avance():
	avance_inputs()
	aplicar_velocidad_segun_angulo()
	

func aplicar_velocidad_segun_angulo():
	
	velocity.x = lerp(velocity.x, cantidad_avance * speed * cos(rotation), move_weight)
	velocity.y = lerp(velocity.y, cantidad_avance * speed * sin(rotation), move_weight)
	
	move_and_slide(velocity)

func avance_inputs():
	cantidad_avance = int(Input.is_action_pressed("p1up")) - int(Input.is_action_pressed("p1down"))

func giro():
	giro_inputs()
	rotar_todo()

func rotar_todo():
	rotation += cantidad_giro * rotation_radians/(2 * PI)

func giro_inputs():
	cantidad_giro = int(Input.is_action_pressed("p1right")) - int(Input.is_action_pressed("p1left"))
	






extends KinematicBody2D



var bullet = preload("res://bullet.tscn")


var cantidad_giro = 0 
var cantidad_avance = 0 

var velocity  = Vector2.ZERO

var rotation_radians = 0.5
var speed = 500
var move_weight = 0.05


func _physics_process(delta):
	move()
	
func _input(event):
	if Input.is_action_just_pressed("p1shoot"):
		shoot()


func shoot():
	fire_bullet(rotation)


func fire_bullet(bullet_direction):
	
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.inertia = velocity * 0.01
	bullet_instance.direction = bullet_direction
	
	get_tree().get_root().add_child(bullet_instance)



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
	






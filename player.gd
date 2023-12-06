extends KinematicBody2D



var bullet = preload("res://bullet.tscn")
var mine = preload("res://mine.tscn")

onready var firerate_timer = $firerate

var cantidad_giro = 0 
var cantidad_avance = 0 

var velocity  = Vector2.ZERO

var rotation_radians = 0.5
var speed = 500
var move_weight = 0.05

var firerate_time = 0.1

func _ready():
	firerate_timer.wait_time = firerate_time
	

func _physics_process(delta):
	move()
	shoot()
	mines()


func mines():
	
	if Input.is_action_pressed("p1mine") and !there_is_a_mine():
		drop_mine()
	
	if Input.is_action_just_released("p1mine") and there_is_a_mine():
		explode_mine()


func there_is_a_mine():
	if get_tree().get_root().get_node("p1mine"):
		return true

func drop_mine():
	
	var mine_instance = mine.instance()
	mine_instance.position = get_global_position()
	mine_instance.parent_velocity = velocity
	mine_instance.direction = rotation
	mine_instance.name = "p1mine"
	
	get_tree().get_root().add_child(mine_instance)

func explode_mine():
	get_tree().get_root().get_node("p1mine").explode()
	print("explota")

func shoot():
	
	if player_is_pressing_shoot() and you_can_shoot():
		firerate_timer.start()
		fire_bullet(rotation)
		
func player_is_pressing_shoot():
	if Input.is_action_pressed("p1shoot"):
		return true
	else:
		return false

func you_can_shoot():
	if firerate_timer.is_stopped():
		return true
	else:
		return false



func fire_bullet(bullet_direction):
	
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.parent_velocity = velocity 
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
	






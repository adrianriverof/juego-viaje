extends Area2D


var direction
var direction_vect = Vector2(0,0)
var speed = 0
var factor_inercia = 0

var parent_velocity = Vector2.ZERO
var inertia = Vector2(0,0)
var velocity = Vector2(0,0)

var damage = 10

var life_time = 0.3


func _ready():
	
	set_destroy_timer()
	
	calcula_inercia()
	aplica_inercia_y_velocidad()
	
func set_destroy_timer():
	$destroy.wait_time = life_time
	$destroy.start()

func calcula_inercia():
	inertia = parent_velocity * factor_inercia
	
func rota_la_direccion():
	direction_vect = direction_vect.rotated(direction)

func aplica_inercia_y_velocidad():
	velocity = inertia + direction_vect * speed

func rotacion_general():
	rotation = direction
	

func _physics_process(delta):
	translate(velocity)
	
func _on_bullet_body_entered(body):
	
	if body.is_in_group("enemy"):
		print("es un enemigo")
		body.take_damage(damage)
		

func _on_destroy_timeout():
	queue_free()

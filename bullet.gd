extends Area2D


var direction
var direction_vect = Vector2(1,0)
var factor_inercia = 0.02

var parent_velocity = Vector2.ZERO
var inertia = Vector2(0,0)
var velocity = Vector2(0,0)

var damage = 1
var speed = 10 # tal vez 20


func _ready():
	calcula_inercia()
	rota_la_direccion()
	aplica_inercia_y_velocidad()
	rotacion_general()
	
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
		#print("es un enemigo")
		body.take_damage(damage)
		
		queue_free()


func _on_auto_despawn_timeout():
	queue_free()

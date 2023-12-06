extends Area2D


var direction
var direction_vect = Vector2(1,0)
var speed = 10
var inertia = Vector2(0,0)
var velocity = Vector2(0,0)


func _ready():
	rota_la_direccion()
	aplica_inercia_y_velocidad()
	rotacion_general()
	
	
func rota_la_direccion():
	direction_vect = direction_vect.rotated(direction)

func aplica_inercia_y_velocidad():
	velocity = inertia + direction_vect * speed

func rotacion_general():
	rotation = direction
	

func _physics_process(delta):
	translate(velocity)
	
	

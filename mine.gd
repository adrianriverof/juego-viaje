extends Area2D




var direction
var direction_vect = Vector2(-1,0)
var speed = 5
var factor_inercia = 0.01

var parent_velocity = Vector2.ZERO
var inertia = Vector2(0,0)
var velocity = Vector2(0,0)

var damage = 100


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
	
	




func explode():
	
	frena_la_mina()
	
	activa_el_area_de_dano()
	
	la_mina_se_destruye_en_un_rato()
	


func frena_la_mina():
	velocity = Vector2.ZERO

func activa_el_area_de_dano():
	$Area2D/CollisionShape2D.disabled = false

func la_mina_se_destruye_en_un_rato():
	$delete_timer.start()


func _on_delete_timer_timeout():
	queue_free()
	



func _on_Area2D_body_entered(body):
	
	
	var distancia = (body.position - position).length()
	
	var explosion_radius = $Area2D/CollisionShape2D.shape.radius
	
	
	if body.is_in_group("enemy"):
		body.take_damage(damage)
	
	if body.is_in_group("player"):
		body.velocity += (body.position - position).normalized() * (2000) * (-distancia + explosion_radius)/explosion_radius
	
	$CPUParticles2D.emitting = true


extends Area2D


var direction
var direction_vect = Vector2(1,0)
var speed = 10
var inertia = Vector2(0,0)
var velocity = Vector2(0,0)


func _ready():
	
	direction_vect = direction_vect.rotated(direction)
	
	velocity = inertia + direction_vect * speed
	rotation = direction
	
func _physics_process(delta):
	translate(velocity)
	
	

extends Area2D


var direction
var direction_vect = Vector2(0,0)
var speed = 20
var inertia = Vector2(0,0)
var velocity = Vector2(0,0)


func _ready():
	velocity = inertia + direction_vect * speed

func _physics_process(delta):
	translate(velocity)
	
	

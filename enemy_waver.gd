extends KinematicBody2D

#onready var player = get_parent().get_node("player")
var player

var player_position = Vector2.ZERO
var player_direction = Vector2.ZERO

var speed = 500
var life = 3

var damage = 1


var angle_orientation = 1



func _ready():
	if player == null:
		player = get_parent().get_node("player")

func _physics_process(delta):
	
	get_player_direction()
	adjust_self_direction()
	move_to_the_player()
	
func get_player_direction():
	
	#player_position = player.position
	
	player_direction = (player.position - self.position).normalized()
	
	#print(player_direction)
	
func adjust_self_direction():
	player_direction = player_direction.rotated(deg2rad(70* angle_orientation))

func move_to_the_player():
	
	move_and_slide(player_direction * speed)
	
	
func take_damage(damage):
	life -= damage
	
	check_if_dead()
	
func check_if_dead():
	
	print("checkeamso")
	if life <= 0: 
		player.take_points(1)
		queue_free()
	


func _on_hurtbox_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage)
	


func _on_change_angle_timeout():
	angle_orientation *= -1

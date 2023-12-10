extends KinematicBody2D

onready var player = get_parent().get_node("player")

var player_position = Vector2.ZERO
var player_direction = Vector2.ZERO

var speed = 50
var life = 3


func _ready():
	print(player)


func _physics_process(delta):
	
	get_player_direction()
	move_to_the_player()
	
func get_player_direction():
	
	#player_position = player.position
	
	player_direction = (player.position - self.position).normalized()
	
	#print(player_direction)
	
func move_to_the_player():
	
	move_and_slide(player_direction * speed)
	
	
	
	
	
	
	

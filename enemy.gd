extends KinematicBody2D

onready var player = get_parent().get_node("player")



func _ready():
	print(player)

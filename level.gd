extends Node2D

onready var enemy = preload("res://enemy.tscn")


func numero_entre_1_y_(number):  
	randomize()    
	return (randi() % number + 1)


func spawn_enemy():
	drop_enemy()
	


func drop_enemy():
	var enemy_instance = enemy.instance()
	enemy_instance.position = get_node("spawn_positions").get_node(str(numero_entre_1_y_(4))).position
	enemy_instance.player = get_node("player")
	
	get_tree().get_root().add_child(enemy_instance)

	


func _on_enemy_spawn_timeout():
	spawn_enemy()

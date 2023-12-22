extends Node2D

onready var enemy = preload("res://enemy.tscn")
onready var enemy_lateral_move = preload("res://enemy_lateral_move.tscn")
onready var enemy_waver = preload("res://enemy_waver.tscn")


var score = 0



func numero_entre_1_y_(number):   # esto es esencialmente un randi_range(from, to_inclusive)
	randomize()    
	return (randi() % number + 1)


func _on_enemy_spawn_timeout():
	spawn_enemy()



func spawn_enemy():
	
	drop_enemy()
	
	print(score)
	
	check_score()


func check_score():
	if score >= 20:
		$"you win".visible = true


func drop_enemy():
	
	var enemy_instance = choose_enemy_instance() # enemy.instance()
	
	enemy_instance.position = calculate_position_to_spawn_enemy()
	enemy_instance.player = get_node("player")
	
	get_tree().get_root().add_child(enemy_instance)

func choose_enemy_instance():
	
	var numero_aleatorio = numero_entre_1_y_(3)
	
	if numero_aleatorio == 1:
		return enemy_lateral_move.instance()
	elif numero_aleatorio == 2:
		return enemy_waver.instance()
	else:
		return enemy.instance()


func calculate_position_to_spawn_enemy():
	var spawn_node = get_node("spawn_positions")
	var quantity_of_spawn_points = spawn_node.get_child_count()
	var posicion_aleatoria = numero_entre_1_y_(quantity_of_spawn_points)
	
	return spawn_node.get_node(str(posicion_aleatoria)).position








extends Node2D

onready var enemy = preload("res://enemy.tscn")
onready var enemy_lateral_move = preload("res://enemy_lateral_move.tscn")
onready var enemy_waver = preload("res://enemy_waver.tscn")


var score = 0

var lateral_percentage = 15
var waver_percentage = 15
var normal_percentage = 70


# enemies
var enemy_life = 3
var enemy_speed = 100
var enemy_damage = 1

var waver_life = 3
var waver_speed = 500
var waver_damage = 1
var waver_angle = 70

var lateral_life = 3
var lateral_speed = 500
var lateral_damage = 1
var lateral_angle = 50





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
	
	if score >= 1000:
		$"you win".visible = true 
	elif score >= 50:
		enemy_speed = 200 # como se cambiaría un atributo de enemigo
	elif score >= 20:
		change_enemy_spawn_time(1) # un ejemplo de como se cambiaría el tiempo de spawn enemigo
	elif score >= 15:
		lateral_percentage = 95  # un test de como sería variar la distribución
		waver_percentage = 0 
		normal_percentage = 5
	elif score >= 10:
		get_node("player").firerate_time *= 0.5 # ejemplo de incrementar un atributo jugador
	

func change_enemy_spawn_time(new_seconds):
	$enemy_spawn.wait_time = new_seconds

func drop_enemy():
	
	var numero_aleatorio = numero_entre_1_y_(100)
	#print(numero_aleatorio)
	
	if numero_aleatorio in range(1,lateral_percentage+1):  # inc, exc
		
		var enemy_instance = enemy_lateral_move.instance()
	
		enemy_instance.position = calculate_position_to_spawn_enemy()
		enemy_instance.player = get_node("player")
		
		
		enemy_instance.damage = lateral_damage
		enemy_instance.speed = lateral_speed
		enemy_instance.angle = lateral_angle
		enemy_instance.life = lateral_life
		
		
		get_tree().get_root().add_child(enemy_instance)

	elif numero_aleatorio in range(lateral_percentage, lateral_percentage + waver_percentage+1):
		
		var enemy_instance = enemy_waver.instance()
	
		enemy_instance.position = calculate_position_to_spawn_enemy()
		enemy_instance.player = get_node("player")
		
		enemy_instance.damage = waver_damage
		enemy_instance.speed = waver_speed
		enemy_instance.angle = waver_angle
		enemy_instance.life = waver_life
		
		get_tree().get_root().add_child(enemy_instance)
		
	elif numero_aleatorio in range(waver_percentage+lateral_percentage, 101):
		
		var enemy_instance = enemy.instance()
	
		enemy_instance.position = calculate_position_to_spawn_enemy()
		enemy_instance.player = get_node("player")
		
		
		enemy_instance.damage = enemy_damage
		enemy_instance.speed = enemy_speed
		enemy_instance.life = enemy_life
		
		
		get_tree().get_root().add_child(enemy_instance)

func calculate_position_to_spawn_enemy():
	var spawn_node = get_node("spawn_positions")
	var quantity_of_spawn_points = spawn_node.get_child_count()
	var posicion_aleatoria = numero_entre_1_y_(quantity_of_spawn_points)
	
	return spawn_node.get_node(str(posicion_aleatoria)).position








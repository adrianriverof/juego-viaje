extends Node2D

onready var enemy = preload("res://enemy.tscn")
onready var enemy_lateral_move = preload("res://enemy_lateral_move.tscn")
onready var enemy_waver = preload("res://enemy_waver.tscn")

onready var player = get_node("player")

var score = 0


var lateral_percentage = 0
var waver_percentage = 0
var normal_percentage = 100


var enemy_life = 3
var enemy_speed = 100
var enemy_damage = 1

var waver_life = 3
var waver_speed = 200
var waver_damage = 1
var waver_angle = 70

var lateral_life = 3
var lateral_speed = 200
var lateral_damage = 1
var lateral_angle = 50





func numero_entre_1_y_(number):   # esto es esencialmente un randi_range(from, to_inclusive)
	randomize()    
	return (randi() % number + 1)


func _on_enemy_spawn_timeout():
	drop_enemy()
	


func update_score(player_score):
	score = player_score
	$score.text = str(score)
	check_score()

func check_score():
	
	if score >= 140:
		pass
	
	
	elif score >= 120:
		change_enemy_spawn_time(1)
		
		lateral_percentage = 20
		waver_percentage = 20
		normal_percentage = 80
	
	
	elif score >= 100:
		change_enemy_spawn_time(1)
		enemy_speed = 200 # como se cambiaría un atributo de enemigo
		
		lateral_percentage = 0
		waver_percentage = 0
		normal_percentage = 100
		
		
	elif score >= 60:
		change_enemy_spawn_time(0.8)
		lateral_percentage = 20
		waver_percentage = 20
		normal_percentage = 60
	
	elif score >= 45:
		change_enemy_spawn_time(1)
		lateral_percentage = 25
		waver_percentage = 50
		normal_percentage = 25
	
	
	elif score >= 40:
		lateral_percentage = 10  # un test de como sería variar la distribución
		waver_percentage = 0
		normal_percentage = 90
		change_enemy_spawn_time(0.2)
	
	elif score >= 20:
		#player.firerate_time *= 0.5 # ejemplo de incrementar un atributo jugador
		lateral_percentage = 20 
		waver_percentage = 0 
		normal_percentage = 80
	
	elif score >= 0: # condiciones iniciales, por comprobar
		change_enemy_spawn_time(1)
		
		lateral_percentage = 0 
		waver_percentage = 0 
		normal_percentage = 100
		
		



func change_enemy_spawn_time(new_seconds):
	$enemy_spawn.wait_time = new_seconds

func drop_enemy():
	
	var numero_aleatorio = numero_entre_1_y_(100)
	#print(numero_aleatorio)
	
	if numero_aleatorio in range(1,lateral_percentage+1):  # inc, exc
		
		spawn_lateral_enemy()
		
	elif numero_aleatorio in range(lateral_percentage, lateral_percentage + waver_percentage+1):
		
		spawn_waver_enemy()
	
	elif numero_aleatorio in range(waver_percentage+lateral_percentage, 101):
		
		spawn_normal_enemy()


func spawn_lateral_enemy():
	
	var enemy_instance = enemy_lateral_move.instance()
	
	enemy_instance.position = calculate_position_to_spawn_enemy()
	enemy_instance.player = player
	
	
	enemy_instance.damage = lateral_damage
	enemy_instance.speed = lateral_speed
	enemy_instance.angle = lateral_angle
	enemy_instance.life = lateral_life
	
	
	get_tree().get_root().add_child(enemy_instance)


func spawn_waver_enemy():
	
	var enemy_instance = enemy_waver.instance()
	
	enemy_instance.position = calculate_position_to_spawn_enemy()
	enemy_instance.player = player
	
	enemy_instance.damage = waver_damage
	enemy_instance.speed = waver_speed
	enemy_instance.angle = waver_angle
	enemy_instance.life = waver_life
	
	get_tree().get_root().add_child(enemy_instance)


func spawn_normal_enemy():
	
	var enemy_instance = enemy.instance()

	enemy_instance.position = calculate_position_to_spawn_enemy()
	enemy_instance.player = player
	
	
	enemy_instance.damage = enemy_damage
	enemy_instance.speed = enemy_speed
	enemy_instance.life = enemy_life
	
	
	get_tree().get_root().add_child(enemy_instance)


func calculate_position_to_spawn_enemy():
	var spawn_node = get_node("spawn_positions")
	var quantity_of_spawn_points = spawn_node.get_child_count()
	var posicion_aleatoria = numero_entre_1_y_(quantity_of_spawn_points)
	
	return spawn_node.get_node(str(posicion_aleatoria)).position


func player_is_dead():
	
	$enemy_spawn.stop()
	$Restart.visible = true

func reset_level():
	get_tree().change_scene("res://scenes/levels/stage_1.tscn")



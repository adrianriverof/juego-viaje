extends KinematicBody2D

onready var powerup_laser = preload("res://powerup_laser.tscn")
onready var powerup_triple = preload("res://powerup_triple.tscn")

var player

var player_position = Vector2.ZERO
var player_direction = Vector2.ZERO

var speed = 100
var life = 3

var damage = 1



func _physics_process(delta):
	
	get_player_direction()
	move_to_the_player()
	adjust_sprite_rotation()
	

func get_player_direction():
	player_direction = (player.position - self.position).normalized()

func move_to_the_player():
	move_and_slide(player_direction * speed)
	
func adjust_sprite_rotation():
	rotation = player_direction.angle()+PI/2




func take_damage(damage_taken):
	life -= damage_taken
	check_if_dead()
	
func check_if_dead():
	if life <= 0: 
		destroy()


func destroy():
	give_points_to_player()
	spawn_powerup()
	
	queue_free()


func give_points_to_player():
	player.take_points(1)



func spawn_powerup():
	
	var number = tirar_dado_d20()
	
	if number == 6:
		generar_powerup(powerup_laser)
		
	elif number == 7:
		generar_powerup(powerup_triple)
		

func tirar_dado_d20():
	var rng = RandomNumberGenerator.new()
	rng.randomize() 
	return (rng.randi_range(1,20))

func generar_powerup(powerup_onready_var):
	var powerup_instance = powerup_onready_var.instance()
	powerup_instance.position = self.position
	get_tree().get_root().add_child(powerup_instance)

func _on_hurtbox_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage)
	

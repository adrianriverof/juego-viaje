extends KinematicBody2D

onready var powerup_laser = preload("res://powerup_laser.tscn")
onready var powerup_triple = preload("res://powerup_triple.tscn")


#onready var player = get_parent().get_node("player")
var player

var player_position = Vector2.ZERO
var player_direction = Vector2.ZERO

var speed = 100
var life = 3

var damage = 1


func _ready():
	#print(player)
	pass

func _physics_process(delta):
	
	get_player_direction()
	move_to_the_player()
	rotation = player_direction.angle()+PI/2
	
func get_player_direction():
	
	#player_position = player.position
	
	player_direction = (player.position - self.position).normalized()
	
	#print(player_direction)
	
func move_to_the_player():
	
	move_and_slide(player_direction * speed)
	
	
func take_damage(damage_taken):
	life -= damage_taken
	
	check_if_dead()
	
func check_if_dead():
	
	print("checkeamso")
	if life <= 0: 
		destroy()
		
		
	
func destroy():
	player.take_points(1)
	spawn_powerup()
	
	queue_free()
	
func spawn_powerup():
	
	var rng = RandomNumberGenerator.new()
	rng.randomize() # al final es tanto lío que vo a acabar volviendo a lo de antes
	var number = rng.randi_range(1,20)
	
	print("ha tirado un dado y ha salido: ", number)
	
	if number == 6:
		print("es 6")
		# estos powerups tal vez deberían estar balanceados de una manera más global
		# como que el juego aumente o reduzca las posibilidades de que se genere
		
		var poweruplaser_instance = powerup_laser.instance()
		poweruplaser_instance.position = self.position
		get_tree().get_root().add_child(poweruplaser_instance)
		
	elif number == 7:
		
		var poweruptriple_instance = powerup_triple.instance()
		poweruptriple_instance.position = self.position
		get_tree().get_root().add_child(poweruptriple_instance)
		
	


func _on_hurtbox_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage)
	

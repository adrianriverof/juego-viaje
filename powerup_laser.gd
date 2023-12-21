extends Area2D



func _on_powerup_laser_body_entered(body):
	if body.is_in_group("player"):
		
		body.get_powerup("laser")
		queue_free()

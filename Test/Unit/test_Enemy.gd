extends "res://addons/gut/test.gd"


var normal_enemy = load("res://enemy.gd")




func test_dice_enemy():
	
	var _enemy = normal_enemy.new()
	var result = _enemy.tirar_dado_d20()
	
	assert_gt(result, 0, "El dado del enemigo debe dar un número mayor de 0")
	assert_lt(result, 21, "El dado enemigo debe dar numero menor a 20")


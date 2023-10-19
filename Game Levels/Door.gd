extends Area2D

var trying_to_leave = false
var trying_to_enter = false
var player : CharacterBody2D

func _process(_delta):
	if trying_to_leave and Input.is_action_just_pressed("swing"):
		player.leave_house()
		global.door_open = false
		trying_to_enter = true
		trying_to_leave = false
		
	elif trying_to_enter and Input.is_action_just_pressed("swing"):
		player.enter_house()
		global.door_open = true
		trying_to_leave = true
		trying_to_enter = false

func _on_body_entered(body):
	if body.is_in_group("player"):
		player = body
		if global.door_open:
			trying_to_leave = true
			trying_to_enter = false
		else:
			trying_to_enter = true
			trying_to_leave = false

func _on_body_exited(body):
	if body.is_in_group("player"):
		player = body
		if global.door_open:
			trying_to_leave = false
		else:
			trying_to_enter = false

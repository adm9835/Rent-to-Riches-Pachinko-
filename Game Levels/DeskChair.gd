extends Area2D

var trying_to_leave = false
var trying_to_enter = false
var player : CharacterBody2D

func _process(_delta):
	if trying_to_leave and global.pc_on and global.exit_pressed:
		player.shutdown_computer()
		global.pc_on = false
		global.exit_pressed = false
		trying_to_enter = true
		trying_to_leave = false
		
	elif trying_to_enter and Input.is_action_just_pressed("swing"):
		player.access_computer()
		global.pc_on = true
		trying_to_leave = true
		trying_to_enter = false

func _on_body_entered(body):
	if body.is_in_group("player"):
		player = body
		if global.pc_on:
			trying_to_leave = true
			trying_to_enter = false
		else:
			trying_to_enter = true
			trying_to_leave = false

func _on_body_exited(body):
	if body.is_in_group("player"):
		player = body
		if global.pc_on:
			trying_to_leave = false
		else:
			trying_to_enter = false

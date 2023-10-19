extends Control

@onready var camera_2d = $"../Camera2D"

func _on_button_pressed():
	camera_2d.zoom *= 4
	camera_2d.position += Vector2(720*.75,480*.75)
	global.start_screen = false
	queue_free()

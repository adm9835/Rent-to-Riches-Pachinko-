extends Camera2D

@onready var player = $"../GameLevel/Player"

func _process(_delta):
	if zoom.x == 4:
		position = player.global_position

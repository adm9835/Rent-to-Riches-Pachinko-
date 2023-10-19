extends Sprite2D

@onready var computer = $".."
@onready var fire_png = preload("res://Art/fire.png")
@onready var stone_png = preload("res://Art/stone.png")
@onready var wood_png = preload("res://Art/wood.png")
@onready var camera_2d = $"../Camera2D"

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = camera_2d.get_global_mouse_position()
	if computer.item_held:
		match computer.held_item:
			"wood":
				set_texture(wood_png)
			"stone":
				set_texture(stone_png)
			"fire":
				set_texture(fire_png)
	else:
		set_texture(null)

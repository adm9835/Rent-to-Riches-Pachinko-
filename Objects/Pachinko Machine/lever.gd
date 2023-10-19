extends Sprite2D

@onready var static_body_2d = $"../StaticBody2D"
@onready var collision_shape_2d = $"../StaticBody2D/CollisionShape2D"
@onready var animation_player = $AnimationPlayer
@onready var drops = $"../Drops"
@onready var dropped = $"../Dropped"
var can_pull = true

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("click") and can_pull:
		activate()

func activate():
	animation_player.play("pull")
	can_pull = false
	collision_shape_2d.disabled = true
	static_body_2d.visible = false
	var droppedchildren = dropped.get_children()
	var dropschildren = drops.get_children()
	for i in droppedchildren:
		i.queue_free()
	for i in dropschildren:
		drops.remove_child(i)
		dropped.add_child(i, true)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "pull":
		frame = 2
		can_pull = true
		collision_shape_2d.disabled = false
		static_body_2d.visible = true


extends RigidBody2D

@export var type : String

func _on_collect_area_body_entered(body):
	if body.is_in_group("player"):
		body.collect(type)
		queue_free()

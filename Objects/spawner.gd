extends Area2D

@onready var tree_scene = preload("res://Objects/Droppers/tree.tscn")
@onready var rock_scene = preload("res://Objects/Droppers/rock.tscn")
@onready var flame_scene = preload("res://Objects/Droppers/flame.tscn")

@onready var tree_timer = $TreeTimer
@onready var rock_timer = $RockTimer
@onready var flame_timer = $FlameTimer

var max_tree = 48
var max_rock = 30
var max_flame = 16


func _on_tree_timer_timeout():
	spawn_tree()
	if global.has_seed:
		spawn_tree()


func _on_rock_timer_timeout():
	spawn_rock()
	if global.has_seed:
		spawn_rock()

func _on_flame_timer_timeout():
	spawn_flame()
	if global.has_seed:
		spawn_flame()
		
func spawn_tree():
	if get_tree().get_root().get_child_count() < max_tree:
		var newtree = tree_scene.instantiate()
		get_tree().get_root().add_child(newtree)
		newtree.position = Vector2(randi_range(32, 600),432)
		
func spawn_rock():
	if get_tree().get_root().get_child_count() < max_rock:
		var newrock = rock_scene.instantiate()
		get_tree().get_root().add_child(newrock)
		newrock.position = Vector2(randi_range(32, 600),432)
	
func spawn_flame():
	if get_tree().get_root().get_child_count() < max_flame:
		var newflame = flame_scene.instantiate()
		get_tree().get_root().add_child(newflame)
		newflame.position = Vector2(randi_range(32, 600),432)


func _on_start_timer_timeout():
	spawn_tree()
	spawn_rock()
	spawn_flame()
	spawn_tree()
	spawn_tree()
	spawn_rock()
	spawn_tree()

extends CharacterBody2D

@onready var camera_2d = $"../../Camera2D"
@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D
@onready var pc_camera = $"../../Computer/Camera2D"
@onready var tile_map = $"../TileMap"
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer
@onready var hit_box = $Sprite2D/HitBox
@onready var walk_sound = $WalkSound
@onready var hit_sound = $HitSound


var GRAVITY = 40
var speed = 30
var jump = -20
var lock_boot = false
var lock_spring = false

var can_swing = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	if velocity.x != 0 and velocity.y == 0:
		walk_sound.stream_paused = false
	else:
		walk_sound.stream_paused = true
	if not global.pc_on and not global.start_screen:
		check_purchases()
		handle_actions()
		move_and_slide()

func check_purchases():
	if global.has_boot and not lock_boot:
		speed = 60
		lock_boot = true
	if global.has_spring and not lock_spring:
		jump = -40
		lock_spring

func handle_actions():
	if Input.is_action_pressed("left"):
		velocity.x = -speed
		animation_tree.set("parameters/conditions/walk", true)
		animation_tree.set("parameters/conditions/not_walk", false)
		animation_tree.set("parameters/jump/blend_position", -1)
		sprite_2d.scale.x = -1
	if Input.is_action_pressed("right"):
		velocity.x = speed
		animation_tree.set("parameters/conditions/walk", true)
		animation_tree.set("parameters/conditions/not_walk", false)
		animation_tree.set("parameters/jump/blend_position", 1)
		sprite_2d.scale.x = 1
	if not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		velocity.x = 0
		animation_tree.set("parameters/conditions/walk", false)
		animation_tree.set("parameters/conditions/not_walk", true)
	if Input.is_action_just_pressed("up"):
		if is_on_floor():
			animation_tree.set("parameters/conditions/jump", true)
			velocity.y = jump
			if not global.has_boot:
				speed = 50
			else:
				speed = 90
		else:
			animation_tree.set("parameters/conditions/jump", false)
	else:
		animation_tree.set("parameters/conditions/jump", false)
	if Input.is_action_pressed("down"):
		pass
	if Input.is_action_just_pressed("swing"):
		animation_tree.set("parameters/conditions/swing", true)
		animation_tree.set("parameters/conditions/not_swing", false)
		can_swing = false
	else:
		animation_tree.set("parameters/conditions/swing", false)
		animation_tree.set("parameters/conditions/not_swing", true)
	if animation_tree.get("parameters/conditions/swing") and animation_tree.get("parameters/conditions/walk"):
		animation_tree.set("parameters/conditions/walk_swing", true)
	else:
		animation_tree.set("parameters/conditions/walk_swing", false)

func collect(drop):
	match drop:
		"wood":
			global.wood_count += 1
		"stone":
			global.stone_count += 1
		"fire":
			global.fire_count += 1

func access_computer():
	pc_camera.make_current()

func shutdown_computer():
	camera_2d.make_current()

func enter_house():
	tile_map.set_layer_enabled(4, false)
	tile_map.set_layer_enabled(2, true)

func leave_house():
	tile_map.set_layer_enabled(4, true)
	tile_map.set_layer_enabled(2, false)
	
func swing():
	if hit_box.has_overlapping_areas():
		var first_hit = hit_box.get_overlapping_areas()[0].get_parent()
		if first_hit.has_method("hit"):
			first_hit.hit()
			hit_sound.play()
	can_swing = true

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "swing" or anim_name == "walk_swing":
		swing()
	if anim_name == "jump" or anim_name == "jump_left":
		if not global.has_boot:
			speed = 30
		else:
			speed = 60


func _on_walk_sound_finished():
	walk_sound.play()

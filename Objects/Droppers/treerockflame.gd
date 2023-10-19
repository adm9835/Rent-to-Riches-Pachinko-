extends Sprite2D

@export var woodstonefire_scene : PackedScene
@export var number_of_hits : int = 10
@export var particle_color : Color = Color.SADDLE_BROWN
@onready var animation_player = $AnimationPlayer
@onready var death_sound = $DeathSound
@onready var alive_sound = $AliveSound
@onready var cpu_particles_2d = $CPUParticles2D
var can_die = true
var particle_timer = 0

func _ready():
	alive_sound.play()
	cpu_particles_2d.color = particle_color

func _process(_delta):
	if particle_timer <= 0:
		cpu_particles_2d.emitting = false
	else:
		cpu_particles_2d.emitting = true
	particle_timer -= 1

func hit():
	number_of_hits -= 1	
	if global.has_tool:
		number_of_hits -= 1
	particle_timer = 2
	if number_of_hits <= 0 and can_die:
		die()

func die():
	can_die = false
	death_sound.play()
	animation_player.play("death")
	var newgood = woodstonefire_scene.instantiate()
	get_tree().get_root().add_child(newgood)
	newgood.position = global_position

func _on_animation_player_animation_finished(_anim_name):
	queue_free()

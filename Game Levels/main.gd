extends Node

@onready var bgm = $BGM
@onready var bgm_2 = $BGM2
@onready var bgm_3 = $BGM3

func _process(_delta):
	if global.start_screen:
		bgm.stream_paused = false
		bgm_2.stream_paused = true
		bgm_3.stream_paused = true
	else:
		bgm.stream_paused = true
		if global.pc_on:
			bgm_2.stream_paused = false
			bgm_3.stream_paused = true
		else:
			bgm_3.stream_paused = false
			bgm_2.stream_paused = true


func _on_bgm_finished():
	bgm.play()


func _on_bgm_2_finished():
	bgm_2.play()


func _on_bgm_3_finished():
	bgm_3.play()

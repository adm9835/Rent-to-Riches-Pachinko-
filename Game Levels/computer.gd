extends Control

@onready var label = $PanelContainer/TabContainer/Game/VBoxContainer/PanelContainer/GridContainer/Label
@onready var label_2 = $PanelContainer/TabContainer/Game/VBoxContainer/PanelContainer/GridContainer/Label2
@onready var label_3 = $PanelContainer/TabContainer/Game/VBoxContainer/PanelContainer/GridContainer/Label3
@onready var label_4 = $PanelContainer/TabContainer/Game/VBoxContainer/PanelContainer2/HBoxContainer/Label
@onready var labela = $PanelContainer/TabContainer/Shop/VBoxContainer/HBoxContainer/PanelContainer/HBoxContainer/Label
@onready var labelb = $PanelContainer/TabContainer/Shop/VBoxContainer/HBoxContainer/PanelContainer/HBoxContainer/Label2
@onready var labelc = $PanelContainer/TabContainer/Shop/VBoxContainer/HBoxContainer/PanelContainer/HBoxContainer/Label3
@onready var labeld = $PanelContainer/TabContainer/Shop/VBoxContainer/HBoxContainer/PanelContainer2/HBoxContainer/Label
@onready var labelz = $PanelContainer/TabContainer/Email/BoxContainer/VBoxContainer/PanelContainer2/HBoxContainer/Label
@export var item_held = false
@export var held_item : String
@onready var camera_2d = $Camera2D
@onready var fire_drop_scene = preload("res://Objects/Drops/fire_drop.tscn")
@onready var stone_drop_scene = preload("res://Objects/Drops/stone_drop.tscn")
@onready var wood_drop_scene = preload("res://Objects/Drops/wood_drop.tscn")
@onready var drops = $PanelContainer/TabContainer/Game/PachinkoMachine/Drops

func _process(_delta):
	label.text = str(global.wood_count)
	label_2.text = str(global.stone_count)
	label_3.text = str(global.fire_count)
	label_4.text = str(global.coin_count)
	labela.text = str(global.wood_count)
	labelb.text = str(global.stone_count)
	labelc.text = str(global.fire_count)
	labeld.text = str(global.coin_count)
	labelz.text = str(global.coin_count)

func _on_button_pressed():
	global.exit_pressed = true

func place_item():
	match held_item:
		"wood":
			var new_drop = wood_drop_scene.instantiate()
			drops.add_child(new_drop)
			new_drop.global_position = camera_2d.get_global_mouse_position()
			new_drop.reparent(drops)
		"stone":
			var new_drop = stone_drop_scene.instantiate()
			drops.add_child(new_drop)
			new_drop.global_position = camera_2d.get_global_mouse_position()
			new_drop.reparent(drops)
		"fire":
			var new_drop = fire_drop_scene.instantiate()
			drops.add_child(new_drop)
			new_drop.global_position = camera_2d.get_global_mouse_position()
			new_drop.reparent(drops)
	item_held = false
	held_item = ""

func _on_wood_grab_gui_input(event):
	if event.is_action_pressed("click") and global.wood_count >= 1 and not item_held:
		global.wood_count -= 1
		item_held = true
		held_item = "wood"

func _on_stone_grab_gui_input(event):
	if event.is_action_pressed("click") and global.stone_count >= 1 and not item_held:
		global.stone_count -= 1
		item_held = true
		held_item = "stone"


func _on_fire_grab_gui_input(event):
	if event.is_action_pressed("click") and global.fire_count >= 1 and not item_held:
		global.fire_count -= 1
		item_held = true
		held_item = "fire"

func _on_dropper_area_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("click") and item_held:
		place_item()

func wood_spawn(score):
	for i in score:
		var new_drop = wood_drop_scene.instantiate()
		get_tree().get_root().add_child.call_deferred(new_drop)
		new_drop.position = global.package_dropoff

func stone_spawn(score):
	for i in score:
		var new_drop = stone_drop_scene.instantiate()
		get_tree().get_root().add_child.call_deferred(new_drop)
		new_drop.position = global.package_dropoff

func fire_spawn(score):
	for i in score:
		var new_drop = fire_drop_scene.instantiate()
		get_tree().get_root().add_child.call_deferred(new_drop)
		new_drop.position = global.package_dropoff

func _on_one_body_entered(body):
	body.get_physics_material_override().bounce = 0
	match body.type:
		"wood":
			wood_spawn(1)
		"stone":
			stone_spawn(1)
		"fire":
			fire_spawn(1)

func _on_one_2_body_entered(body):
	body.get_physics_material_override().bounce = 0
	match body.type:
		"wood":
			wood_spawn(1)
		"stone":
			stone_spawn(1)
		"fire":
			fire_spawn(1)


func _on_five_body_entered(body):
	body.get_physics_material_override().bounce = 0
	match body.type:
		"wood":
			wood_spawn(5)
		"stone":
			stone_spawn(5)
		"fire":
			fire_spawn(5)


func _on_five_2_body_entered(body):
	body.get_physics_material_override().bounce = 0
	match body.type:
		"wood":
			wood_spawn(5)
		"stone":
			stone_spawn(5)
		"fire":
			fire_spawn(5)


func _on_ten_body_entered(body):
	body.get_physics_material_override().bounce = 0
	match body.type:
		"wood":
			wood_spawn(10)
		"stone":
			stone_spawn(10)
		"fire":
			fire_spawn(10)


func _on_ten_2_body_entered(body):
	body.get_physics_material_override().bounce = 0
	match body.type:
		"wood":
			wood_spawn(10)
		"stone":
			stone_spawn(10)
		"fire":
			fire_spawn(10)


func _on_jackpot_body_entered(body):
	body.get_physics_material_override().bounce = 0
	match body.type:
		"wood":
			wood_spawn(25)
		"stone":
			stone_spawn(25)
		"fire":
			fire_spawn(25)


func _on_buy_tool_pressed():
	if global.coin_count >= 100:
		global.coin_count -= 100
		global.has_tool = true
		$PanelContainer/TabContainer/Shop/VBoxContainer/HBoxContainer2/PanelContainer3/VBoxContainer/GridContainer/HBoxContainer/BuyTool.queue_free()

func _on_buy_boot_pressed():
	if global.coin_count >= 150:
		global.coin_count -= 150
		global.has_boot = true
		$PanelContainer/TabContainer/Shop/VBoxContainer/HBoxContainer2/PanelContainer3/VBoxContainer/GridContainer/HBoxContainer2/BuyBoot.queue_free()

func _on_buy_spring_pressed():
	if global.coin_count >= 200:
		global.coin_count -= 200
		global.has_spring = true
		$PanelContainer/TabContainer/Shop/VBoxContainer/HBoxContainer2/PanelContainer3/VBoxContainer/GridContainer/HBoxContainer3/BuySpring.queue_free()

func _on_buy_seed_pressed():
	if global.coin_count >= 250:
		global.coin_count -= 250
		global.has_seed = true
		$PanelContainer/TabContainer/Shop/VBoxContainer/HBoxContainer2/PanelContainer3/VBoxContainer/GridContainer/HBoxContainer4/BuySeed.queue_free()

func _on_sell_wood_pressed():
	if global.wood_count >= 1:
		global.wood_count -= 1
		global.coin_count += 1


func _on_sell_stone_pressed():
	if global.stone_count >= 1:
		global.stone_count -= 1
		global.coin_count += 2


func _on_sell_fire_pressed():
	if global.fire_count >= 1:
		global.fire_count -= 1
		global.coin_count += 3


func _on_rent_button_pressed():
	if global.coin_count >= 1000:
		global.coin_count -= 1000
		$PanelContainer/TabContainer/Email/BoxContainer/PanelContainer/MarginContainer/RichTextLabel2.text = "Thanks! :)"
		$PanelContainer/TabContainer/Email/BoxContainer/PanelContainer/MarginContainer/RentButton.queue_free()


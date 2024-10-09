extends AnimatedSprite2D

@export var water_music: Resource
@export var castle_music: Resource
@export var portal_sfx: Resource

var is_water_portal_open: bool = false
var is_castle_portal_open: bool = false

@onready var ui: CanvasLayer = get_tree().current_scene.get_node("HUD")
@onready var scene: String = get_tree().current_scene.name

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WeaponManager.weapon_1.connect(open_portal_water)
	WeaponManager.weapon_2.connect(open_portal_castle)
	play("new_animation")
	pass # Replace with function body.

func open_portal_water():
	is_water_portal_open = true

func open_portal_castle():
	is_castle_portal_open = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (is_water_portal_open == true and scene == "Main"):
		get_tree().change_scene_to_file("res://water.tscn")
		GlobalAudioManager.play_track(portal_sfx, 1)
		GlobalAudioManager.play_track(water_music, 1)
	elif (is_castle_portal_open == true and scene == "water"):
		get_tree().change_scene_to_file("res://castle.tscn")
		GlobalAudioManager.play_track(castle_music, 0.5)
		GlobalAudioManager.play_track(portal_sfx, 0.5)
	elif (scene == "castle"):
		ui.on_win_game()
		GlobalAudioManager.play_track(portal_sfx, 0.5)
	else:
		ui._portal_warning()
	pass # Replace with function body.

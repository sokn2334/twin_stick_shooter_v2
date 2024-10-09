extends Node2D

@export var bg_music: Resource

@onready var ui: CanvasLayer = get_tree().current_scene.get_node("HUD")

signal game_end
signal game_start
signal game_win

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.game_started.connect(start_game)
	GlobalAudioManager.play_track(bg_music, 0.5)

func end_game():
	var ui: CanvasLayer = get_tree().current_scene.get_node("HUD")
	ui.on_game_over()
	game_end.emit()
	pass

func win_game():
	game_win.emit()
	pass

func start_game():
	game_start.emit()
	pass
	

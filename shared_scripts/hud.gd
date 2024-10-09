extends CanvasLayer

signal game_started
var end_score: int = 0

@export var hover_sfx: Resource

@onready var end_of_game_screen = $end_of_game
@onready var during_game_screen = $during_game
@onready var start_of_game_screen = $start_of_game
@onready var animation_player = $during_game/AnimationPlayer
@onready var win_game_screen = $win_game

@onready var play_button = $start_of_game/PlayButton/PlayButton
@onready var restart_button = $end_of_game/Restart/EndGame

@onready var cur_scene: String = get_tree().get_current_scene().name

@export var bg_music:Resource

func _ready() -> void:
	ScoreManager.score_updated.connect(_update_score)
	ScoreManager.health_updated.connect(_update_health_bar)
	ScoreManager.mana_updated.connect(_update_mana_bar)
	
	MManager.game_end.connect(on_game_over)
	MManager.game_win.connect(on_win_game)
	
	start_of_game_screen.visible = true

	if (cur_scene == "water" or cur_scene == "castle"):
		_on_play_button_pressed()
		WeaponManager.weapon1_achieved()
		if (cur_scene == "castle"):
			_on_play_button_pressed()
			WeaponManager.weapon2_achieved()
	
func _update_score(new_score: int):
	end_score = new_score
	print(end_score)

func _portal_warning():
	$during_game/Label.visible = true
	$during_game/WarningTimer.start()

func _on_warning_timer_timeout() -> void:
	$during_game/Label.visible = false
	$during_game/NewWeapon.visible = false
	pass # Replace with function body.
	
func _weapon_notification():
	$during_game/NewWeapon.visible = true
	$during_game/WarningTimer.start()
	
func on_game_over():
	end_of_game_screen.visible = true
	during_game_screen.visible = false
	$end_of_game/end_score_display/Score.text = "Score: %d" % end_score
	
func on_win_game():
	during_game_screen.visible = false
	win_game_screen.visible = true
	var score = ScoreManager.get_current_score()
	$win_game/win_score_display/Score.text = "Score: %d" % score
	

func _update_health_bar(new_health: int):
	match(new_health):
		0: animation_player.play("to_0")
		1: animation_player.play("to_1")
		2: animation_player.play("to_2")
		3: animation_player.play("to_3")
		4: animation_player.play("to_4")
		5: animation_player.play("to_5")
		6: animation_player.play("to_6")
		7: animation_player.play("to_7")
		8: animation_player.play("to_8")

func _update_mana_bar(new_mana: int):
	match(new_mana):
		0: animation_player.play("mana_to_0")
		1: animation_player.play("mana_to_1")
		2: animation_player.play("mana_to_2")
		3: animation_player.play("mana_to_3")
		4: animation_player.play("mana_to_4")
		5: animation_player.play("mana_to_5")
		6: animation_player.play("mana_to_6")
		7: animation_player.play("mana_to_7")
		8: animation_player.play("mana_to_8")

func _on_restart_pressed() -> void:
	GlobalAudioManager.play_track(bg_music, 0.5)
	end_of_game_screen.visible= false
	during_game_screen.visible = false
	end_score = 0
	get_tree().reload_current_scene()
	ScoreManager.reset_health()
	ScoreManager.reset_score()
	pass # Replace with function body.


func _on_play_button_pressed() -> void:
	game_started.emit()
	during_game_screen.visible = true
	start_of_game_screen.visible = false
	pass # Replace with function body.


func _on_main_game_start() -> void:
	start_of_game_screen.visible = false
	during_game_screen.visible = true 
	pass # Replace with function body.


func _on_play_button_mouse_entered() -> void:
	GlobalAudioManager.play_SFX(hover_sfx, 0.1)
	play_button.self_modulate = Color(0.501961, 0.501961, 0.501961, 1)
	pass # Replace with function body.


func _on_play_button_mouse_exited() -> void:
	play_button.self_modulate = Color(1,1,1,1)
	pass # Replace with function body.


func _on_restart_mouse_entered() -> void:
	GlobalAudioManager.play_SFX(hover_sfx, 0.1)
	restart_button.self_modulate = Color(0.501961, 0.501961, 0.501961, 1)
	pass # Replace with function body.


func _on_restart_mouse_exited() -> void:
	restart_button.self_modulate = Color(1,1,1,1)
	pass # Replace with function body.

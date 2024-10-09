extends CharacterStateMachine
class_name Enemy

@export var hp:int = 3
@export var wounded_sfx:Resource
@export var death_sfx:Resource

func hit(damage_number: int):
	hp -= damage_number
	GlobalAudioManager.play_SFX(wounded_sfx, 0.2)
	if(hp == 0):
		on_change_state($States/Death) #Play an animation on death
		GlobalAudioManager.play_SFX(death_sfx, 0.2)
		ScoreManager.add_score(100)

func _on_attack_range_body_entered(body: Node2D) -> void:
	$BiteTimer.start()
	ScoreManager.change_health(1)
	pass # Replace with function body.

func _on_bite_timer_timeout() -> void:
	ScoreManager.change_health(1)
	$BiteTimer.start()
	pass # Replace with function body.

func _on_attack_range_body_exited(body: Node2D) -> void:
	$BiteTimer.stop()
	pass # Replace with function body.

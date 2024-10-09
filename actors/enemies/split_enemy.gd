extends CharacterStateMachine
class_name SplitEnemy

@export var hp:int = 3
@export var basic_enemy: Resource
@export var wounded_sfx:Resource
@export var death_sfx:Resource

func hit(damage_number: int):
	hp -= damage_number
	GlobalAudioManager.play_SFX(wounded_sfx, 0.2)
	if(hp == 0):
		GlobalAudioManager.play_SFX(death_sfx, 0.2)
		var new_enemy = basic_enemy.instantiate()
		get_parent().add_child(new_enemy)
		new_enemy.position = $ProjectileRefPoint.global_position
		
		var new_enemy2 = basic_enemy.instantiate()
		get_parent().add_child(new_enemy2)
		new_enemy2.position = ($ProjectileRefPoint.global_position) + Vector2(40,40)
		ScoreManager.add_score(100)
		on_change_state($States/DeathSplit) #Play an animation on death


func _on_attack_range_body_entered(body: Node2D) -> void:
	$BiteTimer.start()
	pass # Replace with function body.

func _on_bite_timer_timeout() -> void:

	$BiteTimer.start()
	pass # Replace with function body.

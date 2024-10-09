extends CharacterStateMachine
class_name SmallEnemy

@export var hp:int = 3
@export var projectile_scene: Resource
@export var wounded_sfx:Resource
@export var death_sfx:Resource

func hit(damage_number: int):
	hp -= damage_number
	GlobalAudioManager.play_SFX(wounded_sfx, 0.2)
	if(hp <= 0):
		on_change_state($States/DeathSmall) #Play an animation on death
		GlobalAudioManager.play_SFX(death_sfx, 0.2)
		ScoreManager.add_score(100)


func _on_attack_range_body_entered(body: Node2D) -> void:
	$BiteTimer.start()
	pass # Replace with function body.

func _on_bite_timer_timeout() -> void:
	var player: CharacterBody2D = get_tree().current_scene.get_node("Player")
	var new_projectile = projectile_scene.instantiate()
	get_parent().add_child(new_projectile)
	var projectile_forward = position.direction_to(player.position)
	new_projectile.fire(projectile_forward, 100.0)
	new_projectile.position = $ProjectileRefPoint.global_position
	
	$BiteTimer.start()
	pass # Replace with function body.

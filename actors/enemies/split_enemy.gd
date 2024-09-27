extends CharacterStateMachine
class_name SplitEnemy

@export var hp:int = 3
@export var basic_enemy: Resource

func hit(damage_number: int):
	hp -= damage_number
	if(hp == 0):
		var new_enemy = basic_enemy.instantiate()
		get_parent().add_child(new_enemy)
		new_enemy.position = $ProjectileRefPoint.global_position
		
		var new_enemy2 = basic_enemy.instantiate()
		get_parent().add_child(new_enemy2)
		new_enemy2.position = ($ProjectileRefPoint.global_position) + Vector2(40,40)
		print("count")
		get_tree().get_root().get_node("Main/HUD").add_score(1)
		on_change_state($States/DeathSplit) #Play an animation on death


func _on_attack_range_body_entered(body: Node2D) -> void:
	$BiteTimer.start()
	pass # Replace with function body.

func _on_bite_timer_timeout() -> void:

	$BiteTimer.start()
	pass # Replace with function body.

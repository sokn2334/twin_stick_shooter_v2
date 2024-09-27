extends CharacterStateMachine
class_name Enemy

@export var hp:int = 3

func hit(damage_number: int):
	hp -= damage_number
	if(hp <= 0):
		on_change_state($States/Death) #Play an animation on death
		get_tree().get_root().get_node("Main/HUD").add_score(1)


func _on_attack_range_body_entered(body: Node2D) -> void:
	$BiteTimer.start()
	pass # Replace with function body.

func _on_bite_timer_timeout() -> void:
	$BiteTimer.start()
	pass # Replace with function body.

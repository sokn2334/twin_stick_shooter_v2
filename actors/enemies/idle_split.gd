extends State

var detect_range: Area2D
var chasing_state: State


func initialize():
	detect_range = body.get_node("DetectionRange")
	chasing_state = get_parent().get_node("ChasingSplit")
	var animation_player: AnimationPlayer = get_parent().get_parent().get_node("AnimationPlayer")
	animation_player.play("idle_left")
	
#Called every frame if the state is currently active
func process_state(delta: float):
	var potential_targets = detect_range.get_overlapping_bodies()
	if (not potential_targets.is_empty()):
		chasing_state.target = (potential_targets[0] as CharacterBody2D)
		change_state.emit(chasing_state)

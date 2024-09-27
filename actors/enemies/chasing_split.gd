extends State

@export var chase_speed:float = 100.0
var target: CharacterBody2D

func process_state(delta: float):
	body.velocity = (target.position - body.position).normalized() * chase_speed
	body.move_and_slide()
	var animation_player: AnimationPlayer = get_parent().get_parent().get_node("AnimationPlayer")
	var angle = rad_to_deg(body.velocity.angle()) + 180
	if (angle > 90 and angle < 270):
		animation_player.play("move_right")
	else:
		animation_player.play("move_left")

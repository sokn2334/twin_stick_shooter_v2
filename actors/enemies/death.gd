extends State

var target: CharacterBody2D

func initialize():
	var animation_player: AnimationPlayer = body.get_node("AnimationPlayer")
	animation_player.animation_finished.connect(handle_death)

func handle_death(animation_name):
	if (animation_name == "death_left" or animation_name == "death_right"):
		queue_free()
		
func on_enter_state():
	var animation_player: AnimationPlayer = body.get_node("AnimationPlayer")
	var angle = rad_to_deg(body.velocity.angle()) + 180
	if (angle == 180):
		animation_player.play("death_left")
	elif (angle > 90 and angle < 270):
		animation_player.play("death_right")
	else:
		animation_player.play("death_left")

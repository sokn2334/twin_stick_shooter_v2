extends Area2D

var velocity: Vector2 = Vector2(0,0)

func fire(forward: Vector2, speed: float):
	velocity = (forward * speed)/10
	look_at(position + forward)
	$AnimationPlayer.play("slash_basic")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	position += velocity * delta
	pass


func _on_time_to_live_timeout() -> void:
	queue_free()
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if(body is Enemy):
		(body as Enemy).hit(1)
	elif(body is SmallEnemy):
		(body as SmallEnemy).hit(1)
	elif(body is SplitEnemy):
			(body as SplitEnemy).hit(1)
	queue_free()
	pass # Replace with function body.

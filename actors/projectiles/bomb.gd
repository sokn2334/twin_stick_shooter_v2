extends Area2D

@export var explosion:AnimatedSprite2D
@export var boom:AnimatedSprite2D

var velocity: Vector2 = Vector2(0,0)

func fire():
	#Bombs don't move, the velocity is 0
	velocity = Vector2(0, 0)
	$Boom.animation_finished.connect(_on_animation_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	position += velocity * delta
	
	#Making the macaron change color when it is about to explode
	var time:float = $TimeToLive.get_time_left()
	explosion.play("explode")
	if time > 2:
		explosion.set_speed_scale(0.2)
		pass
	if time > 1:
		explosion.set_speed_scale(1)
		pass
	else:
		explosion.set_speed_scale(4)
		pass
	pass

func _on_time_to_live_timeout() -> void:
	explosion.visible = false
	boom.play("splode")
	pass # Replace with function body.
	
func _on_animation_finished() -> bool:
	if $Boom.animation == "splode":
		boom.stop()
		boom.visible = false
		queue_free()
		return true
	else:
		return false


func _on_body_entered(body: Node2D) -> void:
	if ($Boom._on_animation_finished() == true):
		(body as Enemy).hit(3)
		
	pass # Replace with function body.

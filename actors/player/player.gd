extends CharacterBody2D

@export var projectile_scene: Resource
@export var melee_scene: Resource
@export var bomb_scene: Resource

@export var move_speed: float = 250.0
var prev_direction:String = 'D' 

#Weapon inventory
var weapon_selection:int = 1  

func _input(event):
	if (event is InputEventMouseButton):
		#Only shoot on left click pressed down
		if (event.button_index == 1 and event.is_pressed()):	
			match weapon_selection:
				1:	
					var new_projectile = projectile_scene.instantiate()
					get_parent().add_child(new_projectile)
			
					var projectile_forward = position.direction_to(get_global_mouse_position())
					new_projectile.fire(projectile_forward, 600.0)
					new_projectile.position = $Weapon/ProjectileRefPoint.global_position
				2: 
					var new_projectile = melee_scene.instantiate()
					get_parent().add_child(new_projectile)
			
					var projectile_forward = position.direction_to(get_global_mouse_position())
					new_projectile.fire(projectile_forward, velocity.length())
					new_projectile.position = $Weapon/ProjectileRefPoint.global_position
					
				3: 
					var new_bomb = bomb_scene.instantiate()
					get_parent().add_child(new_bomb)
			
					new_bomb.fire()
					new_bomb.position = $ProjectileRefPoint.global_position
				4: print("four")
			
		

func _physics_process(delta: float):
	#look_at(get_viewport().get_mouse_position())
	$Weapon.rotation = position.direction_to(get_global_mouse_position()).angle()
	$Weapon/Sprite2D.flip_v = ($Weapon.rotation < -PI/2 or $Weapon.rotation > PI/2)
	#Check to see if the player switches weapons 
	if (Input.is_action_just_pressed("weapon_one")):
		weapon_selection = 1
	if (Input.is_action_just_pressed("weapon_two")):
		weapon_selection = 2
	if (Input.is_action_just_pressed("weapon_three")):
		weapon_selection = 3
	if (Input.is_action_just_pressed("weapon_four")):
		weapon_selection = 4		
	
	#Player movement
	velocity = Input.get_vector("move_left", \
		"move_right", "move_up", "move_down")\
	 	* move_speed
	move_and_slide()
	
	#Math to sort out direction and animation
	var angle = rad_to_deg(velocity.angle()) + 180
	if (velocity.length() < 10):
		if (prev_direction == 'D'):
			$AnimationPlayer.play("idol_down")
		elif (prev_direction == 'L'):
			$AnimationPlayer.play("idol_left")
		elif (prev_direction == 'R'):
			$AnimationPlayer.play("idol_right")
		elif (prev_direction == 'U'):
			$AnimationPlayer.play("idol_up")
	else:
		if (angle > 135 and angle < 225):
			$AnimationPlayer.play("move_right")
			prev_direction = 'R'
		elif (angle > 225 and angle < 315):
			$AnimationPlayer.play("move_down")
			prev_direction = 'D'
		elif (angle > 315 or angle < 45):
			$AnimationPlayer.play("move_left")
			prev_direction = 'L'
		#WALK UP ANIMATION!
		elif (angle > 45 and angle < 135):
			$AnimationPlayer.play("move_up")
			prev_direction = 'U'

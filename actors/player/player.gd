extends CharacterBody2D

@export var projectile_scene: Resource
@export var melee_scene: Resource
@export var dualshot_scene: Resource

@export var shoot_sfx: Resource
@export var hit_sfx: Resource

@export var move_speed: float = 250.0
var prev_direction:String = 'D'
@onready var is_game_ended 
@onready var is_game_started

@onready var ui: CanvasLayer = get_tree().current_scene.get_node("HUD")

#Weapon inventory
var weapon_num:int = 1

#Mana Control
var new_mana:int = 8

#When the player gets hit
@export var hp:int = 8
func _ready():
	MManager.game_end.connect(get_hit)
	MManager.game_start.connect(game_starting)
	
	ScoreManager.health_updated.connect(get_hit)
	ScoreManager.mana_updated.connect(_input)
	ScoreManager.mana_updated.connect(handle_mana)
	
	WeaponManager.weapon_1.connect(add_weapon1)
	WeaponManager.weapon_2.connect(add_weapon2)
	
	ui.game_started.connect(game_starting)
	is_game_ended = false 

func get_hit(damage_number: int):
	hp = ScoreManager.current_health
	if (hp > 0):
		GlobalAudioManager.play_SFX(hit_sfx, 0.6)
	if (hp == 0):
		MManager.end_game()
		is_game_ended = true
		is_game_started = false

func handle_mana(mana_num: int):
	new_mana = mana_num
	if (new_mana < 8):
		$ManaTimer.start()

func _on_mana_timeout() -> void:
	new_mana += 1
	ScoreManager.change_mana(-1)
	pass # Replace with function body.

func game_starting():
	is_game_started = true
	

func _input(event):
	if (event is InputEventMouseButton and is_game_ended == false and is_game_started == true):
		#Only shoot on left click pressed down
		if (event.button_index == 1 and event.is_pressed() and new_mana > 0):	
			match weapon_num:
				1:	
					var new_projectile = melee_scene.instantiate()
					get_parent().add_child(new_projectile)
			
					ScoreManager.change_mana(1)
					GlobalAudioManager.play_SFX(shoot_sfx, 0.6) #Play sound
					var projectile_forward = position.direction_to(get_global_mouse_position())
					new_projectile.fire(projectile_forward, 600.0)
					new_projectile.position = $Weapon/ProjectileRefPoint.global_position
			
				2: 
					var new_projectile = projectile_scene.instantiate()
					get_parent().add_child(new_projectile)
			
					ScoreManager.change_mana(1)
					GlobalAudioManager.play_SFX(shoot_sfx, 0.4) #Play sound
					var projectile_forward = position.direction_to(get_global_mouse_position())
					new_projectile.fire(projectile_forward, 600.0)
					new_projectile.position = $Weapon/ProjectileRefPoint.global_position
				3: 
					ScoreManager.change_mana(1)
					GlobalAudioManager.play_SFX(shoot_sfx, 0.4) #Play sound
					
					var dual_rotation: float = 0.2
					for i in 2:
						var new_dualshot = dualshot_scene.instantiate()
						get_parent().add_child(new_dualshot)
						var dualshot_forward = position.direction_to(get_global_mouse_position())
						new_dualshot.fire(dualshot_forward, 600.0, dual_rotation)
						new_dualshot.position = $Weapon/ProjectileRefPoint.global_position
						dual_rotation = -0.2
			
		

func _physics_process(delta: float):
	if (is_game_ended == false and is_game_started == true):
		$Weapon.rotation = position.direction_to(get_global_mouse_position()).angle()
		$Weapon/Sprite2D.flip_v = ($Weapon.rotation < -PI/2 or $Weapon.rotation > PI/2)	
		
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
			elif (angle > 45 and angle < 135):
				$AnimationPlayer.play("move_up")
				prev_direction = 'U'

func add_weapon1():
	weapon_num = 2

func add_weapon2():
	weapon_num = 3

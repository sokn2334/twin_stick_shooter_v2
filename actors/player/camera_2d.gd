# Camera2D.gd
extends Camera2D

@onready var player = $Player # Replace with the actual name of your player node
@onready var camera2d = $Camera2D

func _ready():
	#if player:
		# Set this camera as the current active camera
		#make_current()
	#else:
		#print("Player node not found!")
	camera2d.current = false


func _process(delta):
	if player:
		# Follow the player's position
		global_position = player.global_position

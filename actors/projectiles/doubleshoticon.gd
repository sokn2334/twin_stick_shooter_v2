extends AnimatedSprite2D

@export var collect_sfx: Resource
@onready var ui: CanvasLayer = get_tree().current_scene.get_node("HUD")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("default")
	pass # Replace with function body.


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	WeaponManager.weapon2_achieved()
	GlobalAudioManager.play_SFX(collect_sfx, 0.2)
	ui._weapon_notification()
	queue_free()
	pass # Replace with function body.

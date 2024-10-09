extends Node

signal weapon_1
signal weapon_2

@onready var ui: CanvasLayer = get_tree().current_scene.get_node("HUD")

func weapon1_achieved():
	weapon_1.emit()
	
func weapon2_achieved():
	weapon_2.emit()

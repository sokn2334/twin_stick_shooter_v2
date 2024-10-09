extends Node

signal score_updated
signal health_updated
signal mana_updated

var current_score: int = 0
var current_health: int = 8
var current_mana: int = 8

func add_score(num: int):
	current_score += num
	score_updated.emit(current_score)

func get_current_score():
	return current_score

func reset_score():
	current_score = 0
	score_updated.emit(0)

func change_health(num: int):
	current_health -= num
	health_updated.emit(current_health)
	
func reset_health():
	current_health = 8
	health_updated.emit(current_health)

func change_mana(num: int):
	current_mana -= num
	mana_updated.emit(current_mana)
	
	
	

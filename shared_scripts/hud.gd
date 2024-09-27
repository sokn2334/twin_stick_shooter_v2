extends CanvasLayer

var score:int = 0
#Add functions here to update the HUD then call it outside
func add_score(num: int):
	score += num
	$Label.text = "Score: " + str(score)
	pass

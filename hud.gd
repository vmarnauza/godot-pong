extends CanvasLayer

@onready var score = $Score


func update_score(player, opponent):
	score.text = str(player) + " : " + str(opponent)

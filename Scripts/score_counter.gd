extends Control

var score_label: Label
var score: int = 0

func _ready():
	score_label = get_node("ScoreContainer/ScoreLabel")

func increment_score():
	score += 1
	score_label.text = str(score)
	
func get_score() -> int:
	return score

extends Control

var score_label: Label
var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	score_label = get_node("ScoreContainer/ScoreLabel")

func increment_score():
	score += 1
	score_label.text = str(score)

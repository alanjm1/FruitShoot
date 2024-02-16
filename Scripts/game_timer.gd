extends Control

var restart_button: Button
var time: Label
var final_score_label: Label
var timer: Timer 
var timer_label: Label
var is_game_over: bool = false

var move_instruction: Label
var spin_instruction: Label

func _ready():
	setup_ui()

	timer.wait_time = 30
	timer.start()
	timer.connect("timeout", game_over)
	restart_button.connect("pressed", on_restart_pressed)
	
func setup_ui():
	move_instruction = get_node("MovementInstruction")
	spin_instruction = get_node("SpinInstruction")
	restart_button = get_node("Restart")
	time = get_node("Time")
	timer = get_node("Timer")
	timer_label = get_node("TimerLabel")
	final_score_label = get_node("FinalScoreLabel")
	
	restart_button.hide()
	final_score_label.hide()
	
func setup_game_over_ui_state():
	restart_button.show()
	final_score_label.show()
	timer_label.hide()
	time.hide()
	get_node("/root/Main/Score").hide()

func _process(delta):
	if timer.time_left < 20:
		move_instruction.hide()
		spin_instruction.hide()

	time.text = str(int(timer.time_left))
	
func game_over():
	is_game_over = true
	var final_score = get_node("/root/Main/Score").get("score")
	final_score_label.text = "Your score: %s".format([str(final_score)], "%s")
	setup_game_over_ui_state()

func on_restart_pressed():
	get_tree().reload_current_scene()

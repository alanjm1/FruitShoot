extends Node2D

var timer: Timer
var fruit_scene

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.start()
	
	timer.connect("timeout", on_timeout)
	fruit_scene = load("res://Scenes/fruit.tscn")
	
func spawn_fruit():
	var instantiated = fruit_scene.instantiate()
	instantiated.position = Vector2(randi_range(90, 900), randi_range(12, 600))

	add_child(instantiated)
	
func on_timeout():
	var is_game_over = get_node("/root/Main/GameTimer").get("is_game_over")
	
	if !is_game_over:
		spawn_fruit()
		timer.wait_time = randf_range(0.0, 1.5)
		timer.start()

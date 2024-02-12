extends Node2D

var timer: Timer
var fruit_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = randf_range(0.0, 3.0)
	timer.start()
	
	timer.connect("timeout", on_timeout)
	fruit_scene = load("res://Scenes/fruit.tscn")
	
func spawn_fruit():
	var instantiated = fruit_scene.instantiate()
	instantiated.position = Vector2(randi_range(90, 600), randi_range(12, 400))

	add_child(instantiated)
	
func on_timeout():
	spawn_fruit()
	timer.wait_time = randf_range(0.0, 3.0)
	timer.start()

func body_entered():
	print("entered")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

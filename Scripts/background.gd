extends Node2D
var sprite: Sprite2D
var isForwards: bool = true

var degrees_per_second: float = 4.0

func _ready():
	sprite = get_node("Sprite2D")

func _process(delta):
	# Probably far from optimal, but it kind of works...
	var random = randi_range(0, 1024)
	if random == 32:
		isForwards = true
	elif random == 80:
		isForwards = false

	if (isForwards):
		sprite.rotate(delta * deg_to_rad(degrees_per_second))
	else:
		sprite.rotate(delta * deg_to_rad(-degrees_per_second))
	

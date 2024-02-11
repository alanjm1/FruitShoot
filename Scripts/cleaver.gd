extends CharacterBody2D

@export var speed: int = 400
@export var accel: int = 10
@export var degrees_per_second: float = 360.0

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	if Input.is_action_pressed("spin") && !Input.is_action_pressed("shift"):
		rotate(delta * deg_to_rad(degrees_per_second))
		
	if Input.is_action_pressed("shift") && Input.is_action_pressed("spin"):
		rotate(delta * deg_to_rad(-degrees_per_second))

	#TODO: Fix this
	if (Input.is_action_just_released("spin")):
		var wind_down_time: float = 1.0
		var timer: float = 0.0
		while timer <= wind_down_time:
			rotate(delta * deg_to_rad(degrees_per_second))
			timer += delta

	move_and_slide()

func process(delta: float) -> void:
	pass

extends CharacterBody2D

@export var speed: int = 700
@export var accel: int = 25
@export var degrees_per_second: float = 1080.0

func _physics_process(delta: float):
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	if Input.is_action_pressed("spin") && !Input.is_action_pressed("shift"):
		rotate(delta * deg_to_rad(degrees_per_second))
		
	if Input.is_action_pressed("shift") && Input.is_action_pressed("spin"):
		rotate(delta * deg_to_rad(-degrees_per_second))
		
	if position.x <= -10:
		position.x = get_viewport().size.x + 10
	elif position.x >= get_viewport().size.x + 10:
		position.x = -10
		
	if position.y <= -10:
		position.y = get_viewport().size.y + 10
	elif position.y >= get_viewport().size.y + 10:
		position.y = -10

	move_and_slide()


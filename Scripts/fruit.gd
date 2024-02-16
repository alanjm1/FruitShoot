extends Node2D

var sprite: Sprite2D
var area_2d: Area2D
var collision_polygon: CollisionPolygon2D
var isSpinning: bool
var particles: GPUParticles2D
var load_index: int
var scored: bool = false

var loads = [
	{
		name = "Watermelon",
		resource = load("res://Assets/Sprites/Watermelon.png"),
		path = "res://Assets/Sprites/Watermelon.png",
		particle_colour_code = "#37946e"
	},
	{
		name = "Banana",
		resource = load("res://Assets/Sprites/Banana.png"),
		path = "res://Assets/Sprites/Banana.png",
		particle_colour_code = "#fbf236"
	},
	{
		name = "Pineapple",
		resource = load("res://Assets/Sprites/Pineapple.png"),
		path = "res://Assets/Sprites/Pineapple.png",
		particle_colour_code = "#d98b3d"
	},
	{
		name = "Blueberry",
		resource = load("res://Assets/Sprites/Blueberry.png"),
		path = "res://Assets/Sprites/Blueberry.png",
		particle_colour_code = "#8686b5"
	},
	{
		name = "Strawberry",
		resource = load("res://Assets/Sprites/Strawberry.png"),
		path = "res://Assets/Sprites/Strawberry.png",
		particle_colour_code = "#cd7268"
	}
]

func _ready():
	load_index = randi_range(0, loads.size() - 1)
	sprite = get_node("Sprite2D")
	collision_polygon = get_node("Area2D/CollisionPolygon2D")
	area_2d = get_node("Area2D")
	sprite.texture = loads[load_index].resource
	
	particles = get_node("Particles")
	
	var bitmap = BitMap.new()
	var image = Image.load_from_file(loads[load_index].path)
	bitmap.create_from_image_alpha(image, 0.2)
	var rect = Rect2(0, 0, image.get_width(), image.get_height())
	var polygon: PackedVector2Array = bitmap.opaque_to_polygons(rect)[0]
	
	collision_polygon.polygon = polygon
	collision_polygon.position -= sprite.texture.get_size() / 2

	area_2d.connect("body_entered", body_entered)
	particles.connect("finished", particles_finished)

func body_entered(body):
	if isSpinning:
		if !scored:
			scored = true
			add_score()

		sprite.hide()

		# Get rid of the CollisionPolygon2D so collision can't occur, which retriggers the particles
		area_2d.remove_child(get_node("Area2D/CollisionPolygon2D"))
		remove_child(area_2d)

		setup_particles()
		
		if !particles.emitting:
			particles.restart()
	
func setup_particles():
	# There has to be a better way
	particles.process_material = ParticleProcessMaterial.new()
	particles.process_material.set("color", loads[load_index].particle_colour_code)

	particles.set("explosiveness", 0)
	particles.set("interpolate", true)

	particles.process_material.set("turbulence_enabled", true)
	particles.process_material.set("turbulence_influence_max", 0)
	particles.process_material.set("turbulence_influence_min", 0)
	particles.process_material.set("turbulence_noise_strength", 2.0)
	particles.process_material.set("turbulence_noise_scale", 5)
	particles.process_material.set("turbulence_noise_speed_random", 4)
	particles.process_material.set("turbulence_noise_speed", Vector3(0, 900, 0))
	particles.process_material.set("turbulence_initial_displacement_min", 100)
	particles.process_material.set("turbulence_initial_displacement_max", 100)
	particles.process_material.set("amount", 256)
	particles.process_material.set("scale_min", 8)
	particles.process_material.set("gravity", Vector3(0, 350, 0))
	particles.process_material.set("radial_accel_min", 30)
	particles.process_material.set("emission_shape", 5)

func add_score():
	get_tree().call_group("score_label", "increment_score")
	
func particles_finished():
	queue_free()

func _process(delta):
	isSpinning = Input.is_action_pressed("spin")
	rotate(delta * deg_to_rad(randi_range(10, 180)))

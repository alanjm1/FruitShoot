extends Node2D

var sprite: Sprite2D
var area_2d: Area2D
var collision_polygon: CollisionPolygon2D

var loads = [
	{
		name = "Watermelon",
		resource = load("res://Assets/Sprites/Watermelon.png"),
		path = "res://Assets/Sprites/Watermelon.png"
	},
	{
		name = "Banana",
		resource = load("res://Assets/Sprites/Banana.png"),
		path = "res://Assets/Sprites/Banana.png"
	},
	{
		name = "Pineapple",
		resource = load("res://Assets/Sprites/Pineapple.png"),
		path = "res://Assets/Sprites/Pineapple.png"
	},
	{
		name = "Blueberry",
		resource = load("res://Assets/Sprites/Blueberry.png"),
		path = "res://Assets/Sprites/Blueberry.png"
	},
	{
		name = "Strawberry",
		resource = load("res://Assets/Sprites/Strawberry.png"),
		path = "res://Assets/Sprites/Strawberry.png"
	},
	#{
		#name = "Apple",
		#resource = load("res://Assets/Sprites/Apple.png"),
		#path = "res://Assets/Sprites/Apple.png"
	#}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var load_index = randi_range(0, loads.size() - 1)
	sprite = get_node("Sprite2D")
	collision_polygon = get_node("Area2D/CollisionPolygon2D")
	area_2d = get_node("Area2D")
	sprite.texture = loads[load_index].resource
	
	var bitmap = BitMap.new()
	var image = Image.load_from_file(loads[load_index].path)
	bitmap.create_from_image_alpha(image, 0.2)
	var rect = Rect2(0, 0, image.get_width(), image.get_height())
	var polygon: PackedVector2Array = bitmap.opaque_to_polygons(rect)[0]
	
	collision_polygon.polygon = polygon
	collision_polygon.position -= sprite.texture.get_size() / 2

	area_2d.connect("body_entered", body_entered)

func body_entered(body):
	#TODO: Damage, destroy, move etc
	add_score()
	queue_free()
	
func add_score():
	get_tree().call_group("score_label", "increment_score")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(delta * deg_to_rad(randi_range(10, 180)))

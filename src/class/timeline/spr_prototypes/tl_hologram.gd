extends KinematicBody2D

export var texture: Texture = ImageTexture.new() setget align_region

var sprite: Sprite = Sprite.new()
var collision: CollisionShape2D = CollisionShape2D.new()
var shape: Shape2D = RectangleShape2D.new()

var box_size

class_name TimelineHologram

func _init():
	input_pickable = true
	
	sprite.texture = texture
	collision.shape = shape
	
	add_child(sprite)
	add_child(collision)
	
func _enter_tree():
	box_size = get_parent().box_size
	shape.extents = box_size
	
func _input_event(viewport, event, shape_idx):
	prints(viewport, event, shape_idx)
	pass

func align_region(new_value: Texture):
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

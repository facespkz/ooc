extends ColorRect

var texture: Texture setget align_region

var sprite: Sprite = Sprite.new()
var collision: CollisionShape2D = CollisionShape2D.new()
var shape: Shape2D = RectangleShape2D.new()
var colors: PoolColorArray = [
	'#4000', # default / non-hover
	'#9333', # hover
]

# this is the 'real' size of the box
var box_size2: Vector2
# this is the size that RectangleShape uses, since it extends from center
var box_size: Vector2
var padding: float

var panel: ColorRect

class_name TimelineProjector

func _init():
	var exit_err
	var enter_err
	sprite.texture = texture
	collision.shape = shape
	color = colors[0]
	
	add_child(sprite)
	add_child(collision)
	exit_err = connect('mouse_exited', self, 'set_frame_color', [colors[0]])
	enter_err = connect('mouse_entered', self, 'set_frame_color', [colors[1]])
	if (exit_err != OK) and (enter_err != OK):
		push_error('For some reason, the mouse signals are broken.')

func align_region(new_value: Texture):
	if (new_value.get_width() > 32) or (new_value.get_height() > 32):
		sprite.region_enabled = true
	sprite.texture = new_value
	sprite.position = box_size
	pass

func _enter_tree():
	panel = get_parent().get_parent()
	box_size2 = panel.box_size
	box_size = Vector2(box_size2.x / 2, box_size2.y / 2)
	padding = panel.padding
	rect_min_size = box_size2
	shape.extents = box_size
	self.texture = load('res://asset/act_test/act_test%s.tres' % get_index())

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var gui_mouse_down: bool

func _gui_input(event):
	var ev_name = event.get_class()
	if ev_name == 'InputEventMouseButton' && event.button_index == 1:
		gui_mouse_down = event.is_pressed()
		if gui_mouse_down:
			sprite.position = get_viewport().get_mouse_position()
			sprite.position -= rect_global_position
			sprite.z_index = 1337
		else:
			sprite.position = box_size
			sprite.z_index = 0
	if ev_name == 'InputEventMouseMotion' && gui_mouse_down:
		sprite.position += event.relative
		pass
	pass

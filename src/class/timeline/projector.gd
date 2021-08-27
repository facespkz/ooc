extends ColorRect
class_name TimelineProjector

#var texture: Texture setget align_region

var sprite: Sprite
export(Color) var normal_color = '#4000'
export(Color) var hover_color = '#9333'

# this is the 'real' size of the box
var box_size2: Vector2
# this is the size that RectangleShape uses, since it extends from center
var box_size: Vector2
var padding: float

var panel: ColorRect


func _init():
	var exit_err
	var enter_err
	color = normal_color
	
	exit_err = connect('mouse_exited', self, 'set_frame_color', [normal_color])
	enter_err = connect('mouse_entered', self, 'set_frame_color', [hover_color])
	if (exit_err != OK) and (enter_err != OK):
		push_error('For some reason, the mouse signals are broken.')

func align_region(new_texture: Texture):
	if new_texture.get_size > box_size2:
		sprite.region_enabled = true
	sprite.texture = new_texture
	sprite.position = box_size
	pass

func _enter_tree():
	sprite = $Sprite
	panel = get_parent().get_parent()
	box_size2 = panel.box_size
	box_size = box_size2 / Vector2(2, 2)
	padding = panel.padding
	
	rect_min_size = box_size2
	sprite.position = box_size

func _ready():
	pass # Replace with function body.


var gui_mouse_down: bool
var new_index: int

func _gui_input(event):
	var ev_name = event.get_class()
	if ev_name == 'InputEventMouseButton' && event.button_index == 1:
		gui_mouse_down = event.is_pressed()
		if gui_mouse_down:
			sprite.position = get_viewport().get_mouse_position()
			sprite.position -= rect_global_position
			sprite.z_index = 1
			panel.held = sprite
		else:
			new_index = set_new_index(event)
			sprite.position = box_size
			sprite.z_index = 0
			panel.trade(get_index(), new_index)
			panel.held = null
	if ev_name == 'InputEventMouseMotion' && gui_mouse_down:
		sprite.position += event.relative
		new_index = set_new_index(event)
		pass
	pass


func set_new_index(event):
	var target_v2 = sprite.position.x + (padding / 2)
	var hitbox_width = box_size2.x + padding
	var return_index = int((target_v2 / hitbox_width) + get_index())
	return return_index
	pass

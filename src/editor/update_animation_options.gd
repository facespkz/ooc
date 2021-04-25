extends OptionButton

var root_control: Control
var name_string: String

signal animation_changed


func _ready():
	root_control = get_tree().get_root().get_node('Control')
	pass # Replace with function body.

func _enter_tree():
	var popup = get_popup()
	var catchp = popup.connect('about_to_show', self, 'update_animations_popup')
	var catchpr = popup.connect('index_pressed', self, 'print_idx')
	prints(catchp, catchpr)
	if (catchp != OK) or (catchpr != OK):
		push_error('Animation popup not found.')

func print_idx(index = null):
	print(index)

func update_animations_popup():
	clear()
	for item in root_control.spriteframes.get_animation_names():
		add_item(item)

extends OptionButton

var root_control: Control
var selected_animation: String

signal animation_changed


func _ready():
	root_control = get_tree().get_root().get_node('Control')
	pass # Replace with function body.

func _enter_tree():
	var popup = get_popup()
	var catchp = popup.connect('about_to_show', self, 'update_animations_popup')
	var catchs = popup.connect('index_pressed', self, 'switch')
	if (catchp != OK) or (catchs != OK):
		push_error('Animation popup not found.')

func switch(index = null):
	var new_animation = root_control.spriteframes.get_animation_names()[index]
	root_control.set_animation(new_animation)

func update_animations_popup():
	var prev_idx = selected
	clear()
	for item in root_control.spriteframes.get_animation_names():
		add_item(item)
	select(prev_idx)

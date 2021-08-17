extends SpinBox

class_name SpinBoxScrollable

func _on_gui_input(event):
	if (event.get_class() == 'InputEventMouseButton') and event.pressed:
		match event.button_index:
			4:
				value += step
			5:
				value -= step



func _on_Timeline_fps_changed(new_fps):
	value = new_fps
	pass # Replace with function body.

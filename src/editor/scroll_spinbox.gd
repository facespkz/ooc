extends SpinBox

class_name SpinBoxScrollable

func _on_gui_input(event):
	if (event.get_class() == 'InputEventMouseButton') and event.pressed:
		match event.button_index:
			4:
				value += step
			5:
				value -= step

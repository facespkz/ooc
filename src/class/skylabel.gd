extends Label
class_name SkyLabel

export var death_time: int = 5
export var y_float: int = -3

func _process(delta: float):
	modulate.a -= delta/death_time 
	rect_position.y += y_float*delta
	if modulate.a < 0:
		self.free()
	pass

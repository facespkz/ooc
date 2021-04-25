extends ColorRect
class_name TimelineSlot

func resize_led(new_size: Vector2):
	print('owo')
	print(new_size)
	rect_size = new_size

func _ready():
	name = 'LED'
	color = Color8(255, 255, 255, 255)
	show_behind_parent = true
	pass # Replace with function body.

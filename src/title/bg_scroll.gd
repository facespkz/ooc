extends ParallaxBackground

export(float, 1, 50) var divide_by: float = 30
export(String, 'Left', 'Right') var direction: String = 'Right'

func _ready():
	match direction:
		'Left': divide_by *= -1
		'Right': divide_by *= 1

func _process(_delta):
	scroll_offset.x = int(OS.get_system_time_msecs() / divide_by) % 256

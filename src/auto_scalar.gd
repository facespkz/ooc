extends Node

func _ready():
	if OS.get_name() == "Android":
		get_tree().set_screen_stretch(0, 0, Vector2(640, 360), 3)
	pass

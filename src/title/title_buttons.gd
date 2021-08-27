extends Control

var sprites = SpriteFrames.new()

func _ready():
	pass

func _on_Singleplayer_pressed():
	print("game doesn't fucking exist lol")
	pass

func _on_Multiplayer_pressed():
	print("server doesnt exist either")
	pass

func _on_Editor_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene('res://scene/editor/main.tscn')

func test_icle(file_data):
	print(file_data)

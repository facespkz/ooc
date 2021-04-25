extends ColorRect
class_name Draggable

export var extra_stub: bool = false

export var normal_color: Color = Color(0, 0, 0, 0.3)
export var hover_color: Color = Color(0.3, 0.3, 0.3, 0.3)
var hologram: Sprite

#var deadzone: Rect2
#export var drag_deadzone: Vector2 = Vector2(10, 10)
#export var drag_hold_time: float = 0.5
#var hold_timer: Timer = Timer.new()
#var button_held: bool
#var touch_passthrough: bool

func _enter_tree():
	hologram = get_node("Hologram")
#	hold_timer.connect("timeout",)


#func _on_ToolButton_gui_input(event):
#	if touch_passthrough:
#		get_parent()._on_Timeline_gui_input(event)
#		pass
#	if event.get_class() == "InputEventScreenTouch":
#		print(event.position)
#		if event.pressed:
#			deadzone = Rect2(event.position, drag_deadzone)
#			deadzone.position -= Vector2(drag_deadzone.x / 2,
#										 drag_deadzone.y / 2)
#		
#		pass
#	if event.get_class() == "InputEventMouseButton":
#		print('oh yeah a mouse has been clicked')
#		pass
#	if button_held:
#		print(event)
#	pass # Replace with function body.



func _on_Draggable_gui_input(event):
	pass # Replace with function body.

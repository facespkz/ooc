extends Control

var anim_name_popup: ConfirmationDialog
var anim_name_textbox: LineEdit
export var spriteframes: SpriteFrames

# export(AnimatedSprite) var character

func _ready():
	anim_name_popup = $Popups/AnimationNamer
	anim_name_textbox = $Popups/AnimationNamer/LineEdit
	# avoids flicker on Android
	if OS.get_name() != "Android":
		OS.low_processor_usage_mode = true
#	OS.set_window_title('Character Editing Simulator')
	pass

func _on_New_pressed():
	anim_name_popup.visible = true
	pass # Replace with function body.

func _on_Delete_pressed():
	pass # Replace with function body.


func generate_animation():
	pass


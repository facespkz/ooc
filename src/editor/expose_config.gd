extends Control

var anim_name_popup: ConfirmationDialog
var anim_name_textbox: LineEdit
var timeline: Timeline
var sprite: AnimatedSprite
export var spriteframes: SpriteFrames

# export(AnimatedSprite) var character

func _ready():
	anim_name_popup = $Popups/AnimationNamer
	anim_name_textbox = $Popups/AnimationNamer/LineEdit
	timeline = $SpriteFrameEditor/VBoxContainer/Timeline
	timeline.sprite = $SpriteView/AnimatedSprite
	spriteframes = timeline.sprite.frames
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



func _on_Play_pressed():
	timeline.sprite.play(timeline.sprite.animation)


func _on_Pause_pressed():
	timeline.sprite.stop()


func _on_FromStart_pressed():
	timeline.cursor_set(0)
	timeline.sprite.play()

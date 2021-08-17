extends Control

var anim_name_popup: ConfirmationDialog
var anim_name_textbox: LineEdit
var timeline: Timeline
var sf: SpriteFrameConverter
export var spriteframes: SpriteFrames

signal set_animation(new_animation)

# export(AnimatedSprite) var character

func _ready():
	anim_name_popup = $Popups/AnimationNamer
	anim_name_textbox = $Popups/AnimationNamer/LineEdit
	timeline = $SpriteFrameEditor/VBoxContainer/Timeline
	timeline.sprite = $SpriteView/CenterContainer/Control/AnimatedSprite
	spriteframes = timeline.sprite.frames
	$Popups.visible = true
	# avoids flicker on Android
	if OS.get_name() != "Android":
		OS.low_processor_usage_mode = true
#	OS.set_window_title('Character Editing Simulator')
	sf = SpriteFrameConverter.new()
	emit_signal("set_animation", spriteframes.get_animation_names()[0])
	pass


func _on_Exit_pressed():
	pass # Replace with function body.


func _on_Save_pressed():
	var output = File.new()
	output.open('user://actor.json', File.WRITE_READ)
	pass # Replace with function body.


func _on_Load_pressed():
	var input = File.new()
	input.open('user://actor.json', File.READ)
	pass # Replace with function body.


func _on_New_pressed():
	anim_name_popup.visible = true
	pass # Replace with function body.


func _on_Delete_pressed():
	pass # Replace with function body.


func generate_animation():
	
	pass
	

func _on_FPS_changed(value):
	spriteframes.set_animation_speed(timeline.sprite.animation, value)
	pass # Replace with function body.






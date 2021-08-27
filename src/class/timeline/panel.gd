extends ColorRect
class_name Timeline, 'res://asset/class/timeline.svg'

var held: Sprite
var sprite: AnimatedSprite setget set_sprite
var sprite_index := 0 setget cursor_set
var sprite_array: Array
var thumb_offset: Vector2

# c stands for control :3
var c = {
	'items': HBoxContainer.new(),
	'separator': VSeparator.new(),
}

export(Vector2) var box_size = Vector2(32, 32)
export(float) var padding = 8

signal fps_changed(new_fps)

func grab_sprite_frames():
	var frames: Array
	var current: String = sprite.animation
	var frame_count: int = sprite.frames.get_frame_count(current)
	
	for idx in range(frame_count):
		frames.append(sprite.frames.get_frame(current, idx))
	sprite_array = frames
	return frames
		

func _on_set_animation(new_animation = 'idle'):
	sprite.animation = new_animation
	generate_projectors()
	emit_signal("fps_changed", sprite.frames.get_animation_speed(new_animation))

func _init():
#	sprite = AnimatedSprite.new()
#	rect_clip_content = true
	
	pass


func _ready():
#	sprite.connect('frame_changed', self, 'cursor_set', [-1])
#	generate_projectors()
#	var amount = 4
#	for i in range(amount):
#		sprite_array.append(
#			load('res://asset/act_test/act_test%s.tres' % (i % 4)))
#		c.items.add_child(TimelineProjector.new())
#	adjust()
#	reset_projectors()
	pass

func _on_Play_pressed():
	sprite.play(sprite.animation)

func _on_Pause_pressed():
	sprite.stop()

func _on_FromStart_pressed():
	sprite.stop()
	cursor_set(0)
	sprite.play()


func generate_projectors():
	grab_sprite_frames()
	for child in $Items.get_children():
		child.queue_free()
	for texture in sprite_array:
		var projector = TimelineProjector.new()
		$Items.add_child(projector)
		projector.sprite.texture = texture
		
#	adjust()
	

func set_sprite(new_sprite: AnimatedSprite):
	if !new_sprite.is_connected("frame_changed", self, 'cursor_set_sprite'):
		new_sprite.connect("frame_changed", self, 'cursor_set_sprite')
	sprite = new_sprite
	pass



func _gui_input(event):
	match event.get_class():
		'InputEventMouseButton':
			if event.pressed:
				match event.button_index:
					4: self.sprite_index -= 1
					5: self.sprite_index += 1
		_: pass


func trade(old_index, new_index):
	var current: String = sprite.animation
	new_index = clamp(new_index, 0, $Items.get_child_count() - 1)
	
	var old_sprites = [sprite_array[old_index], sprite_array[new_index]]
	sprite_array[old_index] = old_sprites[1]
	sprite_array[new_index] = old_sprites[0]
	sprite.frames.set_frame(current, old_index, old_sprites[1])
	sprite.frames.set_frame(current, new_index, old_sprites[0])
	sprite.update()
	reset_projectors()

# this setup is kinda stupid, but i can't seem to do it the other way
func reset_projectors():
#	grab_sprite_frames()
	var items = $Items.get_children()
	for i in range(sprite_array.size()):
		items[i].sprite.set_texture(sprite_array[i])


func cursor_set(new_value: int):
	var hbox_max = $Items.get_child_count() - 1
	var delta
	
	sprite.frame = new_value
	
	delta = new_value - sprite_index
	sprite_index = int(clamp(new_value, 0, hbox_max))
	
	if held != null:
		
		held.position.x += (box_size.x + padding) * delta
		
	adjust()

func cursor_set_sprite() -> void:
	cursor_set(sprite.frame)
	pass

func adjust():
	padding = $Items.get('custom_constants/separation')
	$Items.margin_left = -sprite_index * (box_size.x + padding)


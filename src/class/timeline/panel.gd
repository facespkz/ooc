extends ColorRect
class_name Timeline, 'res://asset/class/timeline.svg'

var frames: SpriteFrames
var animation: String

var sprite_index := 0 setget cursor_set
var sprite_array: Array
var thumb_offset: Vector2

export(Vector2) var box_size = Vector2(32, 32)
export(float) var padding = 8

# c stands for control :3
var c = {
	'items': HBoxContainer.new(),
	'separator': VSeparator.new(),
	'animation_player': AnimationPlayer.new()
}


func _init():
	rect_clip_content = true
	
	c.items.set_anchors_preset(Control.PRESET_CENTER)
	c.items.rect_position.y -= box_size.y / 2
	
	c.separator.set('custom_constants/separation', 0)
	c.separator.set_anchors_preset(Control.PRESET_CENTER_TOP)
	c.separator.rect_size = Vector2(0, rect_size.y)
	
	for node in c:
		add_child(c[node])
	pass


func _ready():
	c.items.set('custom_constants/separation', padding)
	
	var amount = 20
	for i in range(amount):
		sprite_array.append(
			load('res://asset/act_test/act_test%s.tres' % (i % 4)))
		c.items.add_child(TimelineProjector.new())
	adjust()
	reset_projectors()
	pass


func _gui_input(event):
	match event.get_class():
		'InputEventMouseButton':
			if event.pressed:
				match event.button_index:
					4: self.sprite_index -= 1
					5: self.sprite_index += 1
		_: pass


func trade(index, new_index):
	index = clamp(index, 0, c.items.get_child_count() - 1)
	new_index = clamp(new_index, 0, c.items.get_child_count() - 1)
	if index == new_index:
		return
	var sprite = sprite_array[index]
	var new_sprite = sprite_array[new_index]
	sprite_array[index] = new_sprite
	sprite_array[new_index] = sprite
	print('trading %s with %s' % [index, new_index])
	reset_projectors()

# this setup is kinda stupid, but i can't seem to do it the other way
func reset_projectors():
	var items = c.items.get_children()
	for i in range(sprite_array.size()):
		items[i].sprite.set_texture(sprite_array[i])


func cursor_set(new_value: int):
	var hbox_max = c.items.get_child_count() - 1
	sprite_index = int(clamp(new_value, 0, hbox_max))
	adjust()


func adjust():
	padding = c.items.get('custom_constants/separation')
	c.items.margin_left = -sprite_index * (box_size.x + padding)

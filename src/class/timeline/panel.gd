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
	'animation_player': AnimationPlayer.new(),
}

export(Vector2) var box_size = Vector2(32, 32)
export(float) var padding = 8


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
	
	var amount = 4
	for i in range(amount):
		sprite_array.append(
			load('res://asset/act_test/act_test%s.tres' % (i % 4)))
		c.items.add_child(TimelineProjector.new())
	adjust()
	reset_projectors()
	pass


func set_sprite(new_sprite: AnimatedSprite):
	sprite = new_sprite
	new_sprite.connect('frame_changed', self, 'cursor_set', [-1])
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
	new_index = clamp(new_index, 0, c.items.get_child_count() - 1)
	
	var old_sprites = [sprite_array[old_index], sprite_array[new_index]]
	sprite_array[old_index] = old_sprites[1]
	sprite_array[new_index] = old_sprites[0]
	reset_projectors()

# this setup is kinda stupid, but i can't seem to do it the other way
func reset_projectors():
	var items = c.items.get_children()
	for i in range(sprite_array.size()):
		items[i].sprite.set_texture(sprite_array[i])


func cursor_set(new_value: int):
	var hbox_max = c.items.get_child_count() - 1
	var delta
	
	if new_value == -1:
		new_value = sprite.frame
	elif new_value > hbox_max:
		new_value = hbox_max
	else:
		sprite.frame = new_value
	
	delta = new_value - sprite_index
	sprite_index = int(clamp(new_value, 0, hbox_max))
	
	if held != null:
		
		held.position.x += (box_size.x + padding) * delta
		
	adjust()


func adjust():
	padding = c.items.get('custom_constants/separation')
	c.items.margin_left = -sprite_index * (box_size.x + padding)

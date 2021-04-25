extends ColorRect


var frames: SpriteFrames
var animation: String

var sprite_index := 0 setget cursor_set
var sprite_array: Array setget regen_coords
var thumb_offset: Vector2

var box_size := Vector2(32, 32)
var padding: float = 8

var coords_array: PoolIntArray

class_name Timeline, 'res://asset/class/timeline.svg'
# c stands for control :3
var c = {
	'items': HBoxContainer.new(),
	'separator': VSeparator.new(),
	'animation_player': AnimationPlayer.new()
}

signal idx_changed(sprite_index)

func _init():
	
	rect_clip_content = true
	
	
	c.items.set_anchors_preset(Control.PRESET_CENTER)
	c.items.rect_position.y -= box_size.y / 2
	c.items.set('custom_constants/separation', padding)
	
	c.separator.set('custom_constants/separation', 0)
	c.separator.set_anchors_preset(Control.PRESET_CENTER_TOP)
	c.separator.rect_size = Vector2(0, rect_size.y)
	
	for node in c:
		add_child(c[node])
	pass


func _ready():
	var amount = 4
	for _i in range(amount):
		c.items.add_child(TimelineProjector.new())
	adjust()
	pass


func _gui_input(event):
	match event.get_class():
		'InputEventMouseButton':
			if event.pressed:
				match event.button_index:
					4: self.sprite_index -= 1
					5: self.sprite_index += 1
		_: pass
		


func regen_coords(array: Array):
	var start = -padding / 2
	var step = box_size.x + padding
	var length = array.size() * step
	return PoolIntArray(range(start, length, step))


func cursor_set(new_value: int):
	var hbox_max = c.items.get_child_count() - 1
	sprite_index = int(clamp(new_value, 0, hbox_max))
	emit_signal('idx_changed')
	adjust()


func adjust():
	padding = c.items.get('custom_constants/separation')
	c.items.margin_left = -sprite_index * (box_size.x + padding)

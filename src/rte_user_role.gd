extends RichTextEffect
class_name RTEUser


var bbcode = 'user'
const COLORS = {
	'operator': '#F44',
	'admin': '#F44',
	'guest': '#888',
	'generic': '#FFF',
}

func _process_custom_fx(char_fx):
	if char_fx.env.has('type'):
		var user_type = char_fx.env.type
		if COLORS.has(user_type):
			char_fx.color = COLORS[user_type]
		else:
			char_fx.color = COLORS.generic
	return true

extends ItemList
var test: StreamTexture
var ipsum: AtlasTexture

func _init() -> void:
	test = load("res://asset/missing.png")
	ipsum = load("res://res_atlastexture.tres")

func _ready() -> void:
	connect("item_selected", self, "switch_animation")
	for i in 12:
		add_icon_item(ipsum)

func switch_animation(anim_idx) -> void:
	var txt: String = get_item_text(anim_idx)
	print(anim_idx, '@', txt)
	
	pass

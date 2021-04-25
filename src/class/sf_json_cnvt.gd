extends Object

class_name SpriteFrameConverter

var hash_ctx: HashingContext

func _ready() -> void:
	hash_ctx = HashingContext.new()

# exports a SpriteFrames to JSON for easier reading on other systems
func as_json(target: SpriteFrames) -> String:
	var acts: Dictionary = {}
	var bank: Dictionary = {}
	
	for act in target.get_animation_names():
		var current: Dictionary
		var frames: PoolStringArray
		
		acts[act] = {}
		current = acts[act]
		frames = get_frames(act, target)
		
		current.frames = []
		current.speed = target.get_animation_speed(act)
		current.loop = target.get_animation_loop(act)
		
		# if we can help it, recycle every frame to save on file size
		for frame in frames:
			var buffer: String = frame
			var b_hash: String
			
#			var err = hash_ctx.start(HashingContext.HASH_SHA256)
#			if err == OK:
#				hash_ctx.update(buffer)
#				b_hash = Marshalls.raw_to_base64(hash_ctx.finish())
			
			b_hash = buffer.sha256_text()
			
			if !bank.has(b_hash):
				bank[b_hash] = frame
			current.frames.append(b_hash)
			
			pass
	
	return to_json({ 'bank': bank, 'acts': acts })

# grabs data from exported JSON to reconstruct a SpriteFrames
func as_spriteframes(target: String) -> SpriteFrames:
	var sf: SpriteFrames = SpriteFrames.new()
	var obj: Dictionary = parse_json(target)
	var acts: Dictionary = obj.acts
	var bank: Dictionary = obj.bank
	
	sf.remove_animation('default')

	for act in acts.keys():
		var data: Dictionary
		
		data = acts[act]
		sf.add_animation(act)
		sf.set_animation_loop(act, data.loop)
		sf.set_animation_speed(act, data.speed)
		for texture in set_frames(data.frames, bank):
			sf.add_frame(act, texture)
		
	return sf
	pass

# gather frames into string array for JSON storage
func get_frames(act: String, target: SpriteFrames) -> PoolStringArray:
	var images: PoolStringArray = PoolStringArray()
	
	for frame in range(target.get_frame_count(act)):
		var texture: Texture # grab frame as a texture
		var image: Image # then get image data
		var png: PoolByteArray # saved as png data
		
		texture = target.get_frame(act, frame)
		image = texture.get_data()
		png = image.save_png_to_buffer()
		images.append(Marshalls.raw_to_base64(png))
	
	return images
	pass

# convert base64 to buffer for conversion into native texture format
func set_frames(frames: PoolStringArray, bank: Dictionary) -> Array:
	var textures: Array = []
	
	for frame in range(frames.size()):
		# grab png data from the array
		var data: PoolByteArray = PoolByteArray([])
		# convert into Godot's native image format
		var image: Image = Image.new()
		# then load data into a texture
		var texture: ImageTexture = ImageTexture.new()

		data = Marshalls.base64_to_raw(bank[frames[frame]])
		image.load_png_from_buffer(data)
		texture.create_from_image(image)
		textures.append(texture)
	
	return textures

	pass

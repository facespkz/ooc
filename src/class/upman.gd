extends FileDialog

export var file_data: Array = []
signal uploaded(files)

class_name UploadManager, 'res://asset/class/upman-icon.svg'


func spawn_file_upload() -> void:
	file_data = []
	match OS.get_name():
		'HTML5':
			JavaScript.eval('pokeftrInput.click()')
			# wait for arrays to be constructed
			while (JavaScript.eval('pokeftrSelected') == false):
				yield(get_tree().create_timer(.2), "timeout")
			for i in range(JavaScript.eval('pokeftrFiles.length')):
				file_data.append(JavaScript.eval('pokeftrFiles[%s]' % i))
			emit_signal('uploaded', file_data)
		_:
			var files_err = connect('files_selected', self, 'set_file_array')
			if files_err != OK:
				push_warning('Couldn\'t seem to retrieve files...')
			visible = true
			# obviously this will break in future, but unfortunately we can't   
			# dialog.get_cancel() or anything like that right now
			var container: HBoxContainer = get_child(2)
			var button_cancel: Button = container.get_child(1)
			var cancel_err = button_cancel.connect(
				'pressed', self, 'set_file_array', [])
			if cancel_err != OK:
				push_warning('ERROR %s: Couldn\'t select cancel' % cancel_err)
			yield(self, 'uploaded')
	pass

func set_file_array(paths) -> void:
	var file: File = File.new()
	var buffer: PoolByteArray
	var err
	
	for path in paths:
		err = file.open(path, File.READ)
		if err == OK:
			buffer = file.get_buffer(file.get_len())
			file_data.append(buffer)
		file.close()
	emit_signal('uploaded', file_data)

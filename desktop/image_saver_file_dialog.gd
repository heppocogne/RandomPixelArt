extends FileDialog

signal saved(path)
signal push_popup_message(type,text)


var save_texture:Texture


func _on_FileDialog_file_selected(path:String):
	var img:Image=save_texture.get_data()
	var save_error:int
	if path.ends_with(".png"):
		save_error=img.save_png(path)
	elif path.ends_with(".exr"):
		save_error=img.save_exr(path)
	elif path.ends_with(".tres") or path.ends_with(".res"):
		save_error=ResourceSaver.save(path,img)
	else:
		# unreachable
		var ext:=""
		var period_index:=path.rfind(".")
		if 0<period_index:
			ext=path.right(period_index)
		emit_signal("push_popup_message",
					PopupMessage.MessageTypes.ERROR_MESSAGE,
					"Unsupported file format '%s'"%ext)
		return
	
	if save_error==OK:
		emit_signal("saved",path)
		emit_signal("push_popup_message",
					PopupMessage.MessageTypes.SUCCESS_MESSAGE,
					"Successfully saved the image to '%s'"%[path])
	else:
		emit_signal("push_popup_message",
					PopupMessage.MessageTypes.ERROR_MESSAGE,
					"Failed to save the image to '%s'\nError code:%d"%[path,save_error])

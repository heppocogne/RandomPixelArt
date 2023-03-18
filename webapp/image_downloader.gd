extends RefCounted

signal push_popup_message(type,text)


var save_texture:Texture2D
var save_ext:String


func dowload_image():
	var img:Image=save_texture.get_data()
	var saved_file:=File.new()
	var filepath:="user://random_pixel_art.temp-"+str(Time.get_unix_time_from_system())+save_ext
	var save_error:int
	if save_ext==".png":
		save_error=img.save_png(filepath)
#	elif save_ext==".exr":
#		save_error=img.save_exr(filepath)
	else:
		# unreachable
		emit_signal("push_popup_message",
				PopupMessage.MessageTypes.ERROR_MESSAGE,
				"Unsupported file format '%s'"%save_ext)
	
	if save_error!=OK:
		emit_signal("push_popup_message",
					PopupMessage.MessageTypes.ERROR_MESSAGE,
					"Failed to save the image to '%s'\nError code:%d"%[filepath,save_error])
	
	saved_file.open(filepath,File.READ)
	var buffer:=saved_file.get_buffer(saved_file.get_length())
	assert(saved_file.file_exists(filepath))
#	assert(saved_file.get_sha256(filepath)!="")
	var download_filename:="random_pixel_art-%s%s"%[saved_file.get_sha256(filepath),save_ext]
	JavaScript.download_buffer(buffer,download_filename)
	emit_signal("push_popup_message",
				PopupMessage.MessageTypes.SUCCESS_MESSAGE,
				"Downloading the image as '%s'"%download_filename)

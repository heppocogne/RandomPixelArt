class_name PixelArtView
extends TextureRect

signal saved(path)

var noises:Array


func _init():
	noises=[]


func _gui_input(event:InputEvent):
	if event is InputEventMouseButton:
		var mb:=event as InputEventMouseButton
		if mb.button_index==BUTTON_RIGHT and mb.pressed:
			$FileDialog.current_dir=get_parent().last_saved_folder
			$FileDialog.current_file=get_parent().last_saved_file
			$FileDialog.popup_centered(Vector2(600,400))


func _on_FileDialog_file_selected(path:String):
	var img:Image=texture.get_data()
	var save_error:int
	if path.ends_with(".png"):
		save_error=img.save_png(path)
	elif path.ends_with(".exr"):
		save_error=img.save_exr(path)
	elif path.ends_with(".tres") or path.ends_with(".res"):
		save_error=ResourceSaver.save(path,img)
	
	if save_error==OK:
		emit_signal("saved",path)


func _on_PixelArtView_resized():
	$SelectionIndicator.rect_size=rect_size


func _on_PixelArtView_mouse_entered():
	$SelectionIndicator.visible=true


func _on_PixelArtView_mouse_exited():
	$SelectionIndicator.visible=false

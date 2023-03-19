class_name PixelArtView
extends TextureRect

var noises:Array
var file_dialog:FileDialog
var downloader:RefCounted
var context_menu:PopupMenu


func _init():
	noises=[]


func _ready():
	context_menu=$ContextMenu
	if !OS.has_feature("web"):
		file_dialog=load("res://desktop/image_saver_file_dialog.tscn").instantiate()
		call_deferred("add_child",file_dialog)
		context_menu.add_item("Save as *.png",0)
		context_menu.add_item("Save as *.exr",1)
	else:
#		assert(OS.has_feature("JavaScript"))
		downloader=load("res://webapp/image_downloader.gd").new()
		context_menu.add_item("Download as *.png",0)
		# save_exr seems to be not working in web export
#		context_menu.add_item("Download as .exr",1)


func _gui_input(event:InputEvent):
	if event is InputEventMouseButton:
		var mb:=event as InputEventMouseButton
		if mb.button_index==MOUSE_BUTTON_RIGHT or mb.button_index==MOUSE_BUTTON_LEFT and mb.pressed:
			context_menu.popup()
			context_menu.position=get_global_mouse_position()


func connect_signals(handler_saved:Object,callback_saved:String,
					handler_push_popup_message:Object,callback_push_popup_message:String):
	if !OS.has_feature("web"):
		# warning-ignore:return_value_discarded
		file_dialog.connect("saved", Callable(handler_saved, callback_saved))
		# warning-ignore:return_value_discarded
		file_dialog.connect("push_popup_message", Callable(handler_push_popup_message, callback_push_popup_message))
	else:
		# warning-ignore:return_value_discarded
		downloader.connect("push_popup_message", Callable(handler_push_popup_message, callback_push_popup_message))


func _on_ContextMenu_id_pressed(id:int):
	var save_ext:String
	if id==0:
		save_ext=".png"
	else:
		save_ext=".exr"
	if !OS.has_feature("web"):
		file_dialog.save_texture=texture
		file_dialog.filters=["*"+save_ext]
		file_dialog.current_dir=get_parent().last_saved_folder
		file_dialog.current_file=get_parent().last_saved_file
		file_dialog.popup_centered(Vector2(600,400))
	else:
		downloader.save_texture=texture
		downloader.save_ext=save_ext
		downloader.dowload_image()


func _on_PixelArtView_resized():
	$SelectionIndicator.size=size


func _on_PixelArtView_mouse_entered():
	$SelectionIndicator.visible=true


func _on_PixelArtView_mouse_exited():
	$SelectionIndicator.visible=false

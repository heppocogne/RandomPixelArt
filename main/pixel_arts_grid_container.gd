extends GridContainer

var h_separation:int=get_theme_constant("h_separation")
#var v_separation:int=get_constant("vseparation")
var last_saved_folder:String
var last_saved_file:String
var pixel_arts:Array

@onready var width_edit:SpinBox=$"../../../ScrollContainer/PanelContainer/MarginContainer/VBoxContainer/Size/MarginContainer/VBoxContainer/Edit/WidthEdit"


func _init():
	pixel_arts=[]


func _update_columns(width:int,scale:float):
	# warning-ignore:narrowing_conversion
	columns=max(int((get_parent().size.x+h_separation)/(width*scale+h_separation)),1)


func _on_ScrollContainer_pixel_scale_changed(scale:float):
	# warning-ignore:narrowing_conversion
	_update_columns(width_edit.value,scale)
	for p in pixel_arts:
		p.custom_minimum_size=get_parent().pixel_scale*p.texture.get_size()


func _on_PixelArtsContainer_resized():
	# warning-ignore:narrowing_conversion
	_update_columns(width_edit.value,get_parent().pixel_scale)


func _on_PixelArtView_saved(path:String):
	last_saved_folder=path.get_base_dir()
	last_saved_file=path.get_basename()

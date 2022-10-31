extends GridContainer

var h_separation:int=get_constant("hseparation")
#var v_separation:int=get_constant("vseparation")

var pixel_arts:Array

onready var width_edit:SpinBox=$"../../../PanelContainer/MarginContainer/VBoxContainer/Size/Edit/WidthEdit"


func _init():
	pixel_arts=[]


func _update_columns(width:int,scale:float):
	columns=max(int((get_parent().rect_size.x+h_separation)/(width*scale+h_separation)),1)


func _on_WidthEdit_value_changed(width:int):
	_update_columns(width,get_parent().pixel_scale)


func _on_ScrollContainer_pixel_scale_changed(scale:float):
	_update_columns(width_edit.value,scale)
	for p in pixel_arts:
		p.rect_min_size=get_parent().pixel_scale*p.texture.get_size()


func _on_PixelArtsContainer_resized():
	_update_columns(width_edit.value,get_parent().pixel_scale)

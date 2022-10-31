extends GridContainer

var h_separation:int=get_constant("hseparation")
#var v_separation:int=get_constant("vseparation")
onready var width_edit:SpinBox=$"../../../PanelContainer/MarginContainer/VBoxContainer/Size/Edit/WidthEdit"


func _update_columns():
	_on_WidthEdit_value_changed(width_edit.value)


func _on_WidthEdit_value_changed(width:int):
	columns=max(int((get_parent().rect_size.x+h_separation)/(width+h_separation)),1)

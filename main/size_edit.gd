class_name SizeEdit
extends SpinBox

export var pair_nodepath:NodePath
var aspect_ratio:float
onready var _pair_node:SpinBox=get_node(pair_nodepath)
onready var keep_aspect_ratio:CheckBox=$"../../KeepAspectRatio"


func _on_WidthEdit_value_changed(v:int):
	pass


func _on_HeightEdit_value_changed(v:int):
	pass

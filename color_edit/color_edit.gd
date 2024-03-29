@tool
class_name ColorEdit
extends HBoxContainer

signal remove_button_pressed(ref_self)

@export var removable:=true: set = set_removable

func set_window_title(title:String):
	$ColorRect/Window.window_title=title


func get_rect_color()->Color:
	return $ColorRect.color


func set_rect_color(c:Color):
	$ColorRect.color=c


func get_weight()->int:
	return int($SpinBox.value)


func set_weight(w:int):
	$SpinBox.value=w


func set_removable(r:bool):
	removable=r
	$CenterContainer/RemoveButton.visible=r


func _on_RemoveButton_pressed():
	emit_signal("remove_button_pressed",self)

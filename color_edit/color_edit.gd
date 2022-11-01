tool
class_name ColorEdit
extends HBoxContainer

func set_window_title(title:String):
	$ColorRect/WindowDialog.window_title=title


func get_rect_color()->Color:
	return $ColorRect.color


func get_weight()->float:
	return $SpinBox.value

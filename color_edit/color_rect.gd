extends ColorRect


func _gui_input(event:InputEvent):
	if event is InputEventMouseButton:
		var mb:=event as InputEventMouseButton
		if mb.pressed:
			$WindowDialog/ColorPicker.color=color
			$WindowDialog.popup_centered($WindowDialog/ColorPicker.rect_size+$WindowDialog.size_ext)


func _on_WindowDialog_popup_hide():
	color=$WindowDialog/ColorPicker.color

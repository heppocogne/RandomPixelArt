extends ColorRect


func _gui_input(event:InputEvent):
	if event is InputEventMouseButton:
		var mb:=event as InputEventMouseButton
		if mb.pressed:
			$Window/ColorPicker.color=color
			$Window.popup_centered($Window/ColorPicker.size+$Window.size_ext)


func _on_WindowDialog_popup_hide():
	color=$Window/ColorPicker.color

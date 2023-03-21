extends ColorRect


func _gui_input(event:InputEvent):
	if event is InputEventMouseButton:
		var mb:=event as InputEventMouseButton
		if mb.pressed:
			$Window/ScrollContainer/ColorPicker.color=color
			$Window.popup_centered($Window/ScrollContainer/ColorPicker.size+$Window.size_ext)


func _on_color_picker_color_changed(color:Color):
	self.color=color

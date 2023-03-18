extends SizeEdit


func _on_WidthEdit_ready():
	aspect_ratio=value/_pair_node.value


func _on_HeightEdit_value_changed(v:int):
	if keep_aspect_ratio.pressed:
		if value!=v*aspect_ratio:
			value=v*aspect_ratio
	else:
		aspect_ratio=value/v


func _on_WidthEdit_value_changed(v:int):
	if !keep_aspect_ratio.button_pressed:
		aspect_ratio=v/_pair_node.value

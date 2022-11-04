extends SizeEdit


func _on_HeightEdit_ready():
	aspect_ratio=_pair_node.value/value


func _on_WidthEdit_value_changed(v:int):
	if keep_aspect_ratio.pressed:
		if value!=v/aspect_ratio:
			value=v/aspect_ratio
	else:
		aspect_ratio=v/value


func _on_HeightEdit_value_changed(v:int):
	if !keep_aspect_ratio.pressed:
		aspect_ratio=_pair_node.value/v

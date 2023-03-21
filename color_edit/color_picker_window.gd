extends Window

const size_ext:=Vector2(16,16)

func _ready():
	$ScrollContainer/ColorPicker.position=Vector2(8,8)


func _on_ColorPicker_resized():
	min_size=$ScrollContainer/ColorPicker.size+size_ext


func _on_close_requested():
	hide()


func _on_focus_exited():
	hide()

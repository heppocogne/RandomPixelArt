extends WindowDialog

const size_ext:=Vector2(16,16)

func _ready():
	$ColorPicker.rect_position=Vector2(8,8)


func _on_ColorPicker_resized():
	rect_min_size=$ColorPicker.rect_size+size_ext

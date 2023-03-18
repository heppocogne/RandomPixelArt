extends Window

const size_ext:=Vector2(16,16)

func _ready():
	$ColorPicker.position=Vector2(8,8)


func _on_ColorPicker_resized():
	custom_minimum_size=$ColorPicker.size+size_ext

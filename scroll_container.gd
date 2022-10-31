extends ScrollContainer

const scale_min:=1.0/16
const scale_max:=64.0
var pixel_scale:=4.0


func _input(event:InputEvent):
	if event is InputEventMouseButton:
		var mb:=event as InputEventMouseButton
		if !mb.pressed:
			return
		if mb.button_index==BUTTON_WHEEL_UP:
			pixel_scale=min(scale_max,pixel_scale*2.0)
		elif mb.button_index==BUTTON_WHEEL_DOWN:
			pixel_scale=max(scale_min,pixel_scale/2.0)

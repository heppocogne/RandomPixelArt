extends ScrollContainer

signal pixel_scale_changed(value)

const scale_min:=1.0/16
const scale_max:=64.0
var pixel_scale:=4.0
var _old_pixle_scale:=pixel_scale
var shift_pressed:=false


func _input(event:InputEvent):
	if event is InputEventKey:
		var key:=event as InputEventKey
		if key.scancode==KEY_SHIFT:
			shift_pressed=key.pressed
			scroll_vertical_enabled=!shift_pressed
		return
	
	if event is InputEventMouseButton:
		var mb:=event as InputEventMouseButton
		if !mb.pressed or !shift_pressed:
			return
		if mb.button_index==BUTTON_WHEEL_UP:
			pixel_scale=min(scale_max,pixel_scale*2.0)
		elif mb.button_index==BUTTON_WHEEL_DOWN:
			pixel_scale=max(scale_min,pixel_scale/2.0)
		if pixel_scale!=_old_pixle_scale:
			emit_signal("pixel_scale_changed",pixel_scale)
			_old_pixle_scale=pixel_scale
		return

@tool
extends SpinBox

@onready var h_slider:HSlider=$"../../HSlider"


func _ready():
	pass


func _on_HSlider_changed():
	if Engine.is_editor_hint():
		h_slider=$"../../HSlider"
	
	if min_value!=h_slider.min_value:
		min_value=h_slider.min_value
	
	if max_value!=h_slider.max_value:
		max_value=h_slider.max_value
	
	if page!=h_slider.page:
		page=h_slider.page
	
	if step!=h_slider.step:
		step=h_slider.step


func _on_HSlider_value_changed(new_value:float):
	if Engine.is_editor_hint():
		h_slider=$"../../HSlider"
	
	if value!=new_value:
		value=new_value

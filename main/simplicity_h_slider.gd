@tool
extends HSlider

@onready var spin_box:SpinBox=$"../Edit/SpinBox"


func _ready():
	pass


func _on_SpinBox_changed():
	if Engine.is_editor_hint():
		spin_box=$"../Edit/SpinBox"
	
	if min_value!=spin_box.min_value:
		min_value=spin_box.min_value
	
	if max_value!=spin_box.max_value:
		max_value=spin_box.max_value
	
	if page!=spin_box.page:
		page=spin_box.page
	
	if step!=spin_box.step:
		step=spin_box.step


func _on_SpinBox_value_changed(new_value:float):
	if Engine.is_editor_hint():
		spin_box=$"../Edit/SpinBox"
	
	if value!=new_value:
		value=new_value

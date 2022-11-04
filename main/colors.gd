tool
extends VBoxContainer

const _scene_ColorEdit:PackedScene=preload("res://color_edit/color_edit.tscn")

var color_parameters:Array setget set_color_parameters,get_color_parameters
var color_rects:Array


# TODO: add simplicity argument for each colors
func _init():
	color_parameters=[]
	color_rects=[]


func _ready():
	color_rects=[$ColorEdit]


func add_color_edit(ce:ColorEdit):
	if ce.get_parent()==null:
		add_child(ce)
		move_child(ce,get_child_count()-2)
	# warning-ignore:return_value_discarded
	ce.connect("remove_button_pressed",self,"_on_ColorEdit_remove_button_pressed",[],CONNECT_ONESHOT)
	color_rects.push_back(ce)


func remove_color_edit(ce:ColorEdit):
	color_rects.erase(ce)
	ce.queue_free()


func set_color_parameters(params:Array):
	if color_rects.size()<params.size():
		while color_rects.size()<params.size():
			add_color_edit(_scene_ColorEdit.instance())
	elif params.size()<color_rects.size():
		while params.size()<color_rects.size():
			remove_color_edit(color_rects.back())
	
	for i in color_rects.size():
		color_rects[i].set_rect_color(params[i][0])
		color_rects[i].set_weight(params[i][1])


# Array of [color,weight]
func get_color_parameters()->Array:
	color_parameters.clear()
	for cr in color_rects:
		color_parameters.push_back([cr.get_rect_color(),cr.get_weight()])
	return color_parameters


func _on_AddButton_pressed():
	add_color_edit(_scene_ColorEdit.instance())


func _on_ColorEdit_remove_button_pressed(ref:ColorEdit):
	remove_color_edit(ref)

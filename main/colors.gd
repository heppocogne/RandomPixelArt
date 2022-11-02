tool
extends VBoxContainer

var color_rects:Array setget set_color_rects


func _init():
	color_rects=[]


func _ready():
	color_rects=[$ColorEdit]


func set_color_rects(crs:Array):
	assert(0<crs.size())
	for cr in color_rects:
		cr.queue_free()
	color_rects=crs


func add_color_edit(ce:ColorEdit):
	if ce.get_parent()==null:
		add_child(ce)
	color_rects.push_back(ce)


func remove_color_edit(ce:ColorEdit):
	color_rects.erase(ce)
	remove_child(ce)


func get_color_parameters()->Array:
	var color_parameters:=Array()
	for cr in color_rects:
		color_parameters.push_back([cr.get_rect_color(),cr.get_weight()])
	return color_parameters

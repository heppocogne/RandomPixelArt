tool
extends VBoxContainer

var color_rects:Array setget set_color_rects
var _hash:int
# Array of [color,weight]
var _color_parameters:Array setget ,get_color_parameters


func _init():
	_color_parameters=[]
	color_rects=[]


func _ready():
	color_rects=[$ColorEdit]
	_hash=color_rects.hash()
	_color_parameters=[color_rects[0].get_rect_color(),color_rects[0].get_weight()]


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
	if _hash!=color_rects.hash():
		_color_parameters.clear()
		for cr in color_rects:
			_color_parameters.push_back([cr.get_rect_color(),cr.get_weight()])
		_hash=color_rects.hash()
	return _color_parameters

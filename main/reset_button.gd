extends Button

# [object,property_path,value]
var initial_values:Array

func _init():
	initial_values=[]


func _on_Main_ready():
	var main:=get_tree().root.get_node("Main")
	for path in main.reset_parameters:
		var colon_index:int=path.find(":")
		var node:Node=main.get_node(path.left(colon_index))
		initial_values.push_back([node,path.right(colon_index),main.get_node_property(path)])


func _on_ResetButton_pressed():
	var kar:CheckButton=$"../Size/MarginContainer/VBoxContainer/KeepAspectRatio"
	var kar_pressed:bool=kar.pressed
	kar.pressed=false
	for a in initial_values:
		a[0].set_indexed(a[1],a[2])
	kar.pressed=kar_pressed

extends Control

const export_parameters:=PoolStringArray([
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/Count/SpinBox:value",
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/Size/Edit/WidthEdit:value",
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/Size/Edit/HeightEdit:value",
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/Symmetry/None:pressed",
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/Symmetry/Horizontal:pressed",
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/Symmetry/Diagonal:pressed",
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/ComplexityEdit/SpinBox:value"
])


func get_node_property(path:String):
	var colon_index:int=path.find(":")
	var node:Node=get_node(path.left(colon_index))
	return node.get_indexed(path.right(colon_index))


func set_node_property(path:String, val):
	var colon_index:int=path.find(":")
	var node:Node=get_node(path.left(colon_index))
	node.set_indexed(path.right(colon_index), val)

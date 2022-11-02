extends Control

const export_parameters:=PoolStringArray([
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/Count/SpinBox:value",
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/Size/MarginContainer/Edit/WidthEdit:value",
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/Size/MarginContainer/Edit/HeightEdit:value",
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/Symmetry/None:pressed",
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/Symmetry/Horizontal:pressed",
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/Symmetry/Diagonal:pressed",
	"BackgroundPanel/HSplitContainer/PanelContainer/MarginContainer/VBoxContainer/Simplicity/Edit/SpinBox:value",
])


# TODO: support another background image (checkerboard, for example)
# TODO: support keep_aspect_ratio
func _ready():
	randomize()


func get_node_property(path:String):
	var colon_index:int=path.find(":")
	var node:Node=get_node(path.left(colon_index))
	return node.get_indexed(path.right(colon_index))


func set_node_property(path:String, val):
	var colon_index:int=path.find(":")
	var node:Node=get_node(path.left(colon_index))
	node.set_indexed(path.right(colon_index), val)

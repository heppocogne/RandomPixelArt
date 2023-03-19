extends Control

var reset_parameters:=PackedStringArray([
	"BackgroundPanel/HSplitContainer/ScrollContainer/PanelContainer/MarginContainer/VBoxContainer/Quantity/SpinBox:value",
	"BackgroundPanel/HSplitContainer/ScrollContainer/PanelContainer/MarginContainer/VBoxContainer/Size/MarginContainer/VBoxContainer/Edit/WidthEdit:value",
	"BackgroundPanel/HSplitContainer/ScrollContainer/PanelContainer/MarginContainer/VBoxContainer/Size/MarginContainer/VBoxContainer/Edit/HeightEdit:value",
	"BackgroundPanel/HSplitContainer/ScrollContainer/PanelContainer/MarginContainer/VBoxContainer/Symmetry/None:button_pressed",
	"BackgroundPanel/HSplitContainer/ScrollContainer/PanelContainer/MarginContainer/VBoxContainer/Symmetry/Horizontal:button_pressed",
	"BackgroundPanel/HSplitContainer/ScrollContainer/PanelContainer/MarginContainer/VBoxContainer/Symmetry/Diagonal:button_pressed",
	"BackgroundPanel/HSplitContainer/ScrollContainer/PanelContainer/MarginContainer/VBoxContainer/NoiseFrequency/Edit/SpinBox:value",
	"BackgroundPanel/HSplitContainer/ScrollContainer/PanelContainer/MarginContainer/VBoxContainer/Colors:color_parameters"
])


# TODO: support hot reload
# TODO: add icons to "Hrizontal" and "Diagonal"
# TODO: support command-line arguments
# TODO: allow larger image size, simplicity and smaller simplicity
# TODO: support horizontal&vertical symmetry
# TODO: support rotational symmetry (90°, 180°)
# TODO: remember generator parameters
func _ready():
	randomize()


func get_node_property(path:String):
	var colon_index:int=path.find(":")
	var node:Node=get_node(path.left(colon_index))
	if !node:
		push_error("node '",path.left(colon_index) ,"' not found:")
		return
	if !(path.right(path.length()-colon_index-1) in node):
		push_error("property '" ,path.right(path.length()-colon_index-1) ,"' not found",)
		return
	return node.get_indexed(path.right(path.length()-colon_index-1))


func set_node_property(path:String, val):
	var colon_index:int=path.find(":")
	var node:Node=get_node(path.left(colon_index))
	if !node:
		push_error("node not found")
		return
	if !(path.right(path.length()-colon_index-1) in node):
		push_error("property not found")
		return
	node.set_indexed(path.right(colon_index-colon_index-1), val)


func _on_change_background_requested(tex:Texture2D):
	$BackgroundPanel.get_theme_stylebox("panel").texture=tex

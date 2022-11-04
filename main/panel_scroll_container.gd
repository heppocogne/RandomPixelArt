tool
extends ScrollContainer

onready var panel_container:PanelContainer=$PanelContainer


func _on_PanelContainer_resized():
	if Engine.editor_hint:
		panel_container=$PanelContainer
		rect_min_size.x=panel_container.rect_size.x
	rect_size.x=panel_container.rect_size.x

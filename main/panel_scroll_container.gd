@tool
extends ScrollContainer

@onready var panel_container:PanelContainer=$PanelContainer


func _on_PanelContainer_resized():
	if !panel_container:
		panel_container=$PanelContainer
	if Engine.is_editor_hint():
		custom_minimum_size.x=panel_container.size.x
	size.x=panel_container.size.x

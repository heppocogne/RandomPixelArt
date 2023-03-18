@tool
extends ScrollContainer

@onready var panel_container:PanelContainer=$PanelContainer


func _on_PanelContainer_resized():
	if Engine.is_editor_hint():
		panel_container=$PanelContainer
		custom_minimum_size.x=panel_container.size.x
	size.x=panel_container.size.x

class_name PopupMessage
extends PanelContainer

# colors from https://github.com/godotengine/godot/blob/c98d6142d0c8cf4ac284a595ad1156a4b74736ad/editor/editor_themes.cpp#L546-L548
const error_color:=Color(1,0.47,0.42)
const success_color:=Color(0.45,0.95,0.5)

enum MessageTypes{
	SUCCESS_MESSAGE,
	ERROR_MESSAGE
}

var text:String: set = set_text
var message_type:int: set = set_message_type


func set_text(t:String):
	text=t
	$Label.text=t


func set_message_type(t:int):
	message_type=t
	if t==MessageTypes.SUCCESS_MESSAGE:
		$Label.add_theme_color_override("font_color",success_color)
	elif t==MessageTypes.ERROR_MESSAGE:
		$Label.add_theme_color_override("font_color",error_color)


func _on_Timer_timeout():
	queue_free()

extends VBoxContainer

const _scene_message_popup:PackedScene=preload("res://popup_messgae/popup_messgae.tscn")

func _on_popup_message_pushed(type:int,text:String):
	var popup:PopupMessage=_scene_message_popup.instance()
	popup.message_type=type
	popup.text=text
	add_child(popup)


func _on_MarginContainer_resized():
	rect_size=$"../HSplitContainer/MarginContainer".rect_size

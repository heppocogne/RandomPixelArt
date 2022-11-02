class_name BackgroundTextureButton
extends TextureButton

signal change_background_request(tex)


func _on_pressed():
	emit_signal("change_background_request",texture_normal)

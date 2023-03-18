extends Button

signal column_update_request(width,scale)

const _scene_pixel_art_view:PackedScene=preload("res://pixel_art_view/pixel_art_view.tscn")

var pixel_art_generator:PixelArtGenerator

@onready var pixel_art_container:GridContainer=$"../../../../../MarginContainer/ScrollContainer/PixelArts"
@onready var count_spinbox:SpinBox=$"../Quantity/SpinBox"
@onready var width_edit:SpinBox=$"../Size/MarginContainer/VBoxContainer/Edit/WidthEdit"
@onready var height_edit:SpinBox=$"../Size/MarginContainer/VBoxContainer/Edit/HeightEdit"
@onready var none_button:CheckBox=$"../Symmetry/None"
@onready var horizontal_button:CheckBox=$"../Symmetry/Horizontal"
@onready var diagonal_button:CheckBox=$"../Symmetry/Diagonal"
@onready var noise_period_edit:SpinBox=$"../NoisePeriod/Edit/SpinBox"
@onready var colors:VBoxContainer=$"../Colors"
@onready var popup_messages:VBoxContainer=$"../../../../../../PopupMessages"


func _init():
	pixel_art_generator=PixelArtGenerator.new()


func _on_GenerateButton_pressed():
	emit_signal("column_update_request",width_edit.value,pixel_art_container.get_parent().pixel_scale)
	for p in pixel_art_container.pixel_arts:
		p.queue_free()
	pixel_art_container.pixel_arts.clear()
	var texture_rect_size:Vector2=pixel_art_container.get_parent().pixel_scale*Vector2(width_edit.value,height_edit.value)
	for i in count_spinbox.value:
		var image:Image
		var pixel_art_view:=_scene_pixel_art_view.instantiate()
		var color_params:Array=colors.get_color_parameters()
		for _i in color_params.size():
			var noise:=FastNoiseLite.new()
			noise.seed=randi()
			noise.period=noise_period_edit.value
			pixel_art_view.noises.push_back(noise)
		if none_button.pressed:
			# warning-ignore:narrowing_conversion
			# warning-ignore:narrowing_conversion
			image=pixel_art_generator.perlin_generate(width_edit.value,height_edit.value,pixel_art_view.noises,color_params)
		elif horizontal_button.pressed:
			# warning-ignore:narrowing_conversion
			# warning-ignore:narrowing_conversion
			image=pixel_art_generator.perlin_generate_horizontal(width_edit.value,height_edit.value,pixel_art_view.noises,color_params)
		elif diagonal_button.pressed:
			# warning-ignore:narrowing_conversion
			# warning-ignore:narrowing_conversion
			image=pixel_art_generator.perlin_generate_diagonal(width_edit.value,height_edit.value,pixel_art_view.noises,color_params)
		var texture:=ImageTexture.new()
		texture.create_from_image(image) #,3
		pixel_art_view.texture=texture
		pixel_art_view.custom_minimum_size=texture_rect_size
		
		pixel_art_container.pixel_arts.push_back(pixel_art_view)
		pixel_art_container.add_child(pixel_art_view)
		pixel_art_view.connect_signals(pixel_art_container,"_on_PixelArtView_saved",
										popup_messages,"_on_popup_message_pushed")

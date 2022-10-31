extends Button

const _scene_pixel_art_view:PackedScene=preload("res://pixel_art_view/pixel_art_view.tscn")

var pixel_art_generator:PixelArtGenerator

onready var pixel_art_container:GridContainer=$"../../../../MarginContainer/ScrollContainer/PixelArtsContainer"
onready var count_spinbox:SpinBox=$"../Count/SpinBox"
onready var width_edit:SpinBox=$"../Size/Edit/WidthEdit"
onready var height_edit:SpinBox=$"../Size/Edit/HeightEdit"
onready var none_button:CheckBox=$"../Symmetry/None"
onready var horizontal_button:CheckBox=$"../Symmetry/Horizontal"


func _init():
	pixel_art_generator=PixelArtGenerator.new()


func _on_GenerateButton_pressed():
	for p in pixel_art_container.pixel_arts:
		p.queue_free()
	pixel_art_container.pixel_arts=[]
	var texture_rect_size:Vector2=pixel_art_container.get_parent().pixel_scale*Vector2(width_edit.value,height_edit.value)
	for i in count_spinbox.value:
		var image:Image
		if none_button.pressed:
			image=pixel_art_generator.generate(width_edit.value,height_edit.value)
		elif horizontal_button.pressed:
			image=pixel_art_generator.generate_horizontal(width_edit.value,height_edit.value)
		var pixel_art_view:=_scene_pixel_art_view.instance()
		var texture:=ImageTexture.new()
		texture.create_from_image(image,3)
		pixel_art_view.texture=texture
		pixel_art_view.rect_min_size=texture_rect_size
		
		pixel_art_container.pixel_arts.push_back(pixel_art_view)
		pixel_art_container.add_child(pixel_art_view)

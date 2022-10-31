extends Button

var pixel_arts:Array
var pixel_art_generator:PixelArtGenerator

onready var pixel_art_container:GridContainer=$"../../../../MarginContainer/ScrollContainer/PixelArtsContainer"
onready var count_spinbox:SpinBox=$"../Count/SpinBox"


func _init():
	pixel_arts=[]
	pixel_art_generator=PixelArtGenerator.new()


func _on_GenerateButton_pressed():
	for p in pixel_arts:
		p.queue_free()
	pixel_arts=[]
	for i in count_spinbox.value:
		pass

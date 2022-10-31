class_name PixelArtGenerator
extends Reference


func generate(width:int,height:int)->Image:
	var image:=Image.new()
	image.create(width,height,false,Image.FORMAT_BPTC_RGBA)
	image.lock()
	for y in height:
		for x in width:
			image.set_pixel(x,y,Color(randf(),randf(),randf(),randf()))
	image.unlock()
	return image

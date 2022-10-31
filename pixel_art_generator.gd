class_name PixelArtGenerator
extends Reference


func generate(width:int,height:int)->Image:
	var image:=Image.new()
	image.create(width,height,false,Image.FORMAT_RGBA8)
	image.lock()
	for y in height:
		for x in width:
			image.set_pixel(x,y,Color(randf(),randf(),randf(),randf()))
	image.unlock()
	return image


func generate_horizontal(width:int,height:int)->Image:
	var image:=Image.new()
	image.create(width,height,false,Image.FORMAT_RGBA8)
	image.lock()
	for y in height:
		for x in width/2:
			var c:=Color(randf(),randf(),randf(),randf())
			image.set_pixel(x,y,c)
			image.set_pixel(width-x-1,y,c)
		if width%2:
			image.set_pixel(width/2+1,y,Color(randf(),randf(),randf(),randf()))
	image.unlock()
	return image

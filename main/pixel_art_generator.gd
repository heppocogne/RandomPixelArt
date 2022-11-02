class_name PixelArtGenerator
extends Reference

# TODO: support generation with specific color(s)
# TODO: support complexity
# TODO: support smoothness
# TODO: remove random_generate*()


func random_generate(width:int,height:int)->Image:
	var image:=Image.new()
	image.create(width,height,false,Image.FORMAT_RGBA8)
	image.lock()
	for y in height:
		for x in width:
			image.set_pixel(x,y,Color(randf(),randf(),randf(),randf()))
	image.unlock()
	return image


func random_generate_horizontal(width:int,height:int)->Image:
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


func random_generate_diagonal(width:int,height:int)->Image:
	if width!=height:
		var s:int=min(width,height)
		return random_generate_diagonal(s,s)
	
	var image:=Image.new()
	image.create(width,height,false,Image.FORMAT_RGBA8)
	image.lock()
	for y in height:
		for x in y:
			var c:=Color(randf(),randf(),randf(),randf())
			image.set_pixel(x,y,c)
			image.set_pixel(y,x,c)
		image.set_pixel(y,y,Color(randf(),randf(),randf(),randf()))
	image.unlock()
	return image


func perlin_generate(width:int,height:int)->Image:
	var image:=Image.new()
	image.create(width,height,false,Image.FORMAT_RGBA8)
	image.lock()
	for y in height:
		for x in width:
			pass
	image.unlock()
	return image

class_name PixelArtGenerator
extends Reference

# TODO: support perlin_generate_diagonal
# TODO: remove random_generate*()

class _PoolGrayImage:
	extends Reference
	
	var width:=0
	var height:=0
	var data:PoolByteArray
	
	
	static func _create_instance()->_PoolGrayImage:
		return _PoolGrayImage.new()
	
	
	func create_from_image(image:Image,normalize:=false):
		assert(image and image.get_format()==Image.FORMAT_L8)
		width=image.get_width()
		height=image.get_height()
		assert(0<width and 0<height)
		data=PoolByteArray()
		image.lock()
		for y in height:
			_copy_y_impl(image,y)
		image.unlock()
		
		if normalize:
			var value_range:=get_value_range()
			for i in data.size():
				data[i]=range_lerp(data[i],value_range[0],value_range[1],0,255)
	
	
	func _copy_y_impl(locked_image:Image,y:int):
		for x in width:
			# r=g=b, a=1
			data.append(locked_image.get_pixel(x,y).r8)
	
	
	func index(x:int,y:int)->int:
		assert(0<=x and x<width)
		assert(0<=y and y<height)
		return x+y*width
	
	
	func get_pixel(x:int,y:int)->int:
		return data[index(x,y)]
	
	
	func set_pixel(x:int,y:int,v:int):
		assert(0<=v and v<256)
		data[index(x,y)]=v
	
	
	func get_max()->int:
		var m:=0
		for v in data:
			m=max(v,m)
		return m
	
	
	func get_min()->int:
		var m:=255
		for v in data:
			m=min(v,m)
		return m
	
	
	func get_value_range()->PoolByteArray:
		var min_value:=255
		var max_value:=0
		for v in data:
			min_value=min(min_value,v)
			max_value=max(max_value,v)
		return PoolByteArray([min_value,max_value])
	
	
	func get_binary(thresh:int)->_PoolGrayImage:
		var result:=_create_instance()
		result.width=width
		result.height=height
		var bin_data:=PoolByteArray()
		for v in data:
			if thresh<=v:
				bin_data.append(255)
			else:
				bin_data.append(0)
		result.data=bin_data
		return result
	
	
	func get_histogram()->PoolByteArray:
		var hg:=PoolByteArray()
		hg.resize(256)
		hg.fill(0)
		for v in data:
			hg[v]+=1
		
		return hg


class _PoolGrayImageSymmetry:
	extends _PoolGrayImage
	
	static func _create_instance()->_PoolGrayImage:
		return _PoolGrayImageSymmetry.new()
	
	
	func get_histogram()->PoolByteArray:
		var hg:=PoolByteArray()
		hg.resize(256)
		hg.fill(0)
		for v in data:
			hg[v]+=2
		
		return _modify_histgram(hg)
	
	
	func _modify_histgram(hg:PoolByteArray)->PoolByteArray:
		return hg


class _PoolGrayImageHorizontal:
	extends _PoolGrayImageSymmetry
	
	
	static func _create_instance()->_PoolGrayImage:
		return _PoolGrayImageHorizontal.new()
	
	
	func _copy_y_impl(locked_image:Image,y:int):
		for x in width/2:
			# r=g=b, a=1
			data.append(locked_image.get_pixel(x,y).r8)
		if width%2:
			data.append(locked_image.get_pixel(width/2,y).r8)
	
	
	func index(x:int,y:int)->int:
		assert(0<=x and x<width)
		assert(0<=y and y<height)
		var half:int=ceil(width/2.0)
		if x<half:
			return y*half+x
		else:
			return y*half+(width-x-1)
	
	
	func _modify_histgram(hg:PoolByteArray)->PoolByteArray:
		if width%2:
			for y in height:
				hg[get_pixel(width/2,y)]-=1
		return hg


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


func _perlin_generate_main(width:int,height:int,noises:Array,color_params:Array,
							pool_gray_image_object:Object,copy_bin_y_method:String)->Image:
	var image:=Image.new()
	image.create(width,height,false,Image.FORMAT_RGBA8)
	image.lock()
	
	for i in color_params.size():
		var n:OpenSimplexNoise=noises[i]
		var color:Color=color_params[i][0]
		var weight:int=color_params[i][1]
		var pgi:_PoolGrayImage=pool_gray_image_object.call("_create_instance")
		pgi.create_from_image(n.get_image(width,height),true)
		
		var thresh:int=0
		if weight==0:
			thresh=256
		else:
			var hs:=pgi.get_histogram()
			var count:=0
			var pixels:=width*height
			for t in range(255,-1,-1):	# 255,254,...,1,0
				count+=hs[t]
				if weight<=100.0*count/pixels:
					thresh=t
					break
		var bin:=pgi.get_binary(thresh)
		
		for y in height:
			self.call(copy_bin_y_method,image,bin,color,y)
	image.unlock()
	return image


static func _copy_bin_y_impl(locked_image:Image,bin:_PoolGrayImage,color:Color,y:int):
	for x in locked_image.get_width():
		if bin.get_pixel(x,y):
			locked_image.set_pixel(x,y,color)


func perlin_generate(width:int,height:int,noises:Array,color_params:Array)->Image:
	return _perlin_generate_main(width,height,noises,color_params,_PoolGrayImage,"_copy_bin_y_impl")


static func _copy_bin_y_horizontal_impl(locked_image:Image,bin:_PoolGrayImage,color:Color,y:int):
	var width:=locked_image.get_width()
	for x in width/2:
		if bin.get_pixel(x,y):
			locked_image.set_pixel(x,y,color)
			locked_image.set_pixel(width-x-1,y,color)
	if width%2 and bin.get_pixel(width/2,y):
		locked_image.set_pixel(width/2,y,color)


func perlin_generate_horizontal(width:int,height:int,noises:Array,color_params:Array)->Image:
	return _perlin_generate_main(width,height,noises,color_params,_PoolGrayImageHorizontal,"_copy_bin_y_horizontal_impl")

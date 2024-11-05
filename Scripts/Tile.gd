class_name Tile

var location : Vector2i = Vector2i(-1,-1)

func setup(start_location : Vector2i):
	location = start_location

func return_location():
	return location

func return_x():
	return location.x
	
func return_y():
	return location.y

func update_location(new_location : Vector2i):
	location = new_location

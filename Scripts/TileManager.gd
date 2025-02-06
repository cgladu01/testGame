class_name TileManager

var layers : Array[TileMapLayer]
var tiles = []

var shift_x = -1
var shift_y = -1

var width = -1
var height = -1
var depth = -1

var astar2Grid = null

const TERRAIN_LAYER: int = 0
const ENTITIY_LAYER: int = 1

func setup(input_layers : Array[TileMapLayer], width: int, height : int, depth : int = 2):
	layers = input_layers
	self.width = width
	self.height = height
	self.depth = depth
	tiles.resize(width)    # X-dimension
	for x in width:    # this method should be faster than range since it uses a real iterator iirc
		tiles[x] = []
		tiles[x].resize(height)    # Y-dimension
		for y in height:
			tiles[x][y] = []
			tiles[x][y].resize(depth)    # Z-dimension
			for z in depth:
				var newTile = null
				if layers[z] != null and layers[z].get_cell_atlas_coords(Vector2i(x, y) + Global.tileShift) == Vector2i(7,1):
					newTile = Obstacle.new()
				else:
					newTile = EmptyTile.new()
				newTile.setup(Vector2i(x, y))
				tiles[x][y][z] = newTile
			

func change_tile(new_tile : Tile, location : Vector3i):
	if location.x >= width or location.x < 0:
		return
	elif location.y >= height or location.y < 0:
		return
	elif location.z >= depth or location.z < 0:
		return

	tiles[location.x][location.y][location.z] = new_tile
	
	
func change_tile_entity(new_tile : Tile, location : Vector2i):
	if location.x >= width or location.x < 0:
		return
	elif location.y >= height or location.y < 0:
		return

	tiles[location.x][location.y][1] = new_tile

	if astar2Grid:
		if new_tile is Character or new_tile is Enemy:
			astar2Grid.set_point_solid(location, true)

func get_tile(location : Vector3i) -> Tile:
	if location.x >= width or location.x < 0:
		return
	elif location.y >= height or location.y < 0:
		return
	elif location.z >= depth or location.z < 0:
		return
	
	return tiles[location.x][location.y][location.z]

func get_tile_entity(location : Vector2i) -> Tile:
	if location.x >= width or location.x < 0:
		return
	elif location.y >= height or location.y < 0:
		return
	
	return tiles[location.x][location.y][1]

func move_entity(startTile: Entities, location: Vector2i):
	var oldTile = Tile.new()
	oldTile.setup(startTile.location)
	self.change_tile_entity(oldTile, oldTile.location)
	startTile.location = Vector2i(location)
	self.change_tile_entity(startTile, location)

func distance(tile_one: Vector2i, tile_two: Vector2i):
	var diff = (tile_one - tile_two).abs()
	return diff.x + diff.y

func find_closet_open_tile(tile_start: Vector2i, tile_two: Vector2i, max : int = 1, endtile : bool = false) -> Vector2i:
	if endtile and get_tile_entity(tile_two) is EmptyTile:
		return tile_two
	else:
		var tile: Vector2i = Vector2i(-1,-1)

		if max == 1:
			for x in range(1, max + 1):
				for y in range(0, max + 1):
					if x == max and y == max:
						break
					
					tile = do_distance_comparison(x, y, tile_two, tile_start)
					if tile != Vector2i(-1,-1):
						return tile
		else:
			for x in range(1, max + 1):
				for y in range(0, max + 1):
					if x + y == max:
						break
					tile = do_distance_comparison(x, y, tile_two, tile_start)
					if tile != Vector2i(-1,-1):
						return tile

		print("Hello")
		return tile_start

func do_distance_comparison(x: int, y: int, tile_two: Vector2i, tile_start: Vector2i) -> Vector2i:
	var destination = Vector2i(-1,-1)
	var dist = 999

	var array = [
		distance(tile_two + Vector2i(x, y), tile_start) if get_tile_entity(tile_two + Vector2i(x, y)) is EmptyTile  else -1,
		distance(tile_two - Vector2i(x, y), tile_start) if get_tile_entity(tile_two - Vector2i(x, y)) is EmptyTile else -1,
		distance(tile_two + Vector2i(-x, y), tile_start) if get_tile_entity(tile_two + Vector2i(-x, y)) is EmptyTile else -1,
		distance(tile_two + Vector2i(x, -y), tile_start) if get_tile_entity(tile_two + Vector2i(x, -y)) is EmptyTile else -1,
		]

	var partnerArray = [
		tile_two + Vector2i(x, y),
		tile_two - Vector2i(x, y),
		tile_two + Vector2i(-x, y),
		tile_two + Vector2i(x, -y)
	]

	for i in range(0, 4):
		if dist < array[i] or (dist == 999 and array[i] != -1):
			dist = array[i]
			destination = partnerArray[i]

	return destination

func getPath(start: Vector2i, end: Vector2i, mod : int = 0):
	var path = null
	
	# Doing movement for enemies
	if mod == 1:
		for characters in Global.characters:
			astar2Grid.set_point_solid(characters.location, true)
		path = astar2Grid.get_id_path(start, end, true)
		for characters in Global.characters:
			astar2Grid.set_point_solid(characters.location, false)
	# Doing movement for characters
	else:
		for enemy in Global.enemies:
			astar2Grid.set_point_solid(enemy.location, true)
		path = astar2Grid.get_id_path(start, end, true)
		for enemy in Global.enemies:
			astar2Grid.set_point_solid(enemy.location, false)
		
	return path

func _init():
	pass

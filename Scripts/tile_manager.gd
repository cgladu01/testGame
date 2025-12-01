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

var tileTypeReader : TileTypeReader = TileTypeReader.new()

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

			var floor_tile = get_tile_type_from_atlas(layers[0].get_cell_source_id(Vector2i(x,y)), layers[0].get_cell_atlas_coords(Vector2i(x,y)))
			if floor_tile:
				floor_tile.update_location(Vector2i(x, y))
				var entity_tile = EmptyTile.new()
				entity_tile.update_location(Vector2i(x, y))
				tiles[x][y][1] = entity_tile

			tiles[x][y][0] = floor_tile
			

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

func get_floor_tile(location : Vector3i) -> Tile:
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

func find_closet_open_tile(tile_start: Vector2i, tile_two: Vector2i, max : int = 2, endtile : bool = false) -> Vector2i:
	if endtile and get_tile_entity(tile_two) is EmptyTile:
		return tile_two
	else:
		var tile: Vector2i = Vector2i(-1,-1)

		for dist in range(1, max + 1):
			for x in range(0, dist + 1):
				for y in range(0, dist + 1):
					if (x == 0 and y == 0) or (x == dist and y == dist):
						continue
					
					var pot_tile = do_distance_comparison(x, y, tile_two, tile_start)
					tile = pot_tile if getPath(tile_start, pot_tile, 1) < getPath(tile_start, tile, 1) or tile == Vector2i(-1,-1) else tile
			if tile != Vector2i(-1, -1):
				return tile
	
	return Vector2i(-1,-1)

func do_distance_comparison(x: int, y: int, tile_two: Vector2i, tile_start: Vector2i) -> Vector2i:
	var destination = Vector2i(-1,-1)
	var dist = 999

	var array = [
		getPath(tile_start, tile_two + Vector2i(x, y), 1).size() if get_tile_entity(tile_two + Vector2i(x, y)) is EmptyTile  else -1,
		getPath(tile_two - Vector2i(x, y), tile_start, 1).size() if get_tile_entity(tile_two - Vector2i(x, y)) is EmptyTile else -1,
		getPath(tile_start, tile_two + Vector2i(-x, y), 1).size() if get_tile_entity(tile_two + Vector2i(-x, y)) is EmptyTile else -1,
		getPath(tile_start, tile_two + Vector2i(x, -y), 1).size() if get_tile_entity(tile_two + Vector2i(x, -y)) is EmptyTile else -1,
		]
	

	var partnerArray = [
		tile_two + Vector2i(x, y),
		tile_two - Vector2i(x, y),
		tile_two + Vector2i(-x, y),
		tile_two + Vector2i(x, -y)
	]

	for i in range(0, 4):
		if (array[i] < dist and array[i] != -1) or (dist == 999 and array[i] != -1):
			dist = array[i]
			destination = partnerArray[i]

	return destination

func getPath(start: Vector2i, end: Vector2i, mod : int = 0) -> Array[Vector2i]:
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

func get_tile_type_from_atlas(source_id: int, atlas_cord: Vector2i) -> Tile:
	return tileTypeReader.getTileType(source_id, atlas_cord)

func get_entities_within(location: Vector2i, max_dist : int, enemy: int = 1) -> Array[Entities]:
	var returner : Array[Entities] = []
	for x in range(0, max_dist + 1):
		for y in range(0, max_dist + 1 - x):
			if (x == 0 and y == 0):
				continue

			var array = []
			if x == 0 or y == 0:
				array.append_array([
					location + Vector2i(x, y),
					location - Vector2i(x, y),
				])
			else:
				array.append_array([
					location + Vector2i(x, y),
					location - Vector2i(x, y),
					location + Vector2i(-x, y),
					location + Vector2i(x, -y)
				])


			for pot in array:
				if get_tile_entity(pot) is Enemy and enemy == 1:
					returner.append(get_tile_entity(pot))
				elif get_tile_entity(pot) is Character and enemy == 0:
					returner.append(get_tile_entity(pot))

	return returner

func isOnboard(location: Vector2i) -> bool:

	if location.x < 0 or location.x >= height:
		return false
	if location.y < 0 or location.y >= width:
		return false
	return true if get_tile_entity(location) != Obstacle else false

func _init():
	pass

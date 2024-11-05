class_name TileManager

var layers : Array[TileMapLayer]
var tiles = []

var shift_x = -1
var shift_y = -1

var width = -1
var height = -1
var depth = -1

var astar2Grid: AStarGrid2D = null

const TERRAIN_LAYER: int = 0
const ENTITIY_LAYER: int = 1

func setup(input_layers : Array[TileMapLayer], width: int, height : int, depth : int):
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
				var newTile = Tile.new()
				newTile.setup(Vector2i(x, y))
				tiles[x][y][z] = newTile
			

func change_tile(new_tile : Tile, location : Vector3i):
	if location.x + shift_x >= width or location.x + shift_x < 0:
		return
	elif location.y + shift_y >= height or location.y + shift_y < 0:
		return
	elif location.z >= depth or location.z < 0:
		return

	tiles[location.x + shift_x][location.y + shift_y][location.z] = new_tile
	
	
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
	if location.x + shift_x >= width or location.x + shift_x < 0:
		return
	elif location.y + shift_y >= height or location.y + shift_y < 0:
		return
	elif location.z >= depth or location.z < 0:
		return
	
	return tiles[location.x + shift_x][location.y + shift_y][location.z]

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
	
func _init():
	pass

extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.selectionTile = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func clearSelection() -> void:
	self.clear()

# Marks tiles in an outward pattern. Deosn't care for obstacles or what not.
func markTiles(startTile : Vector2i, begin : int, end: int):
	if end == 1:
		for x in range(begin, end + 1):
			for y in range(begin, end + 1):
				if x == end and  y == end:
					break
				if Global.tileManager.get_tile_entity(startTile + Vector2i(x, y)) != null: self.set_cell(startTile + Vector2i(x, y), 11, Vector2i(3,7))
				if Global.tileManager.get_tile_entity(startTile - Vector2i(x,y)) != null:self.set_cell(startTile - Vector2i(x,y), 11, Vector2i(3, 7))
				if Global.tileManager.get_tile_entity(startTile + Vector2i(-x, y)) != null:self.set_cell(startTile + Vector2i(-x, y), 11, Vector2i(3,7))
				if Global.tileManager.get_tile_entity(startTile + Vector2i(x,-y)) != null:self.set_cell(startTile + Vector2i(x,-y), 11, Vector2i(3, 7))
	else:
		for x in range(begin, end + 1):
			for y in range(begin, end + 1):
				if x + y == end:
					break
				if Global.tileManager.get_tile_entity(startTile + Vector2i(x, y)) != null:self.set_cell(startTile + Vector2i(x, y), 11, Vector2i(3,7))
				if Global.tileManager.get_tile_entity(startTile - Vector2i(x,y)) != null:self.set_cell(startTile - Vector2i(x,y), 11, Vector2i(3, 7))
				if Global.tileManager.get_tile_entity(startTile + Vector2i(-x, y)) != null:self.set_cell(startTile + Vector2i(-x, y), 11, Vector2i(3,7))
				if Global.tileManager.get_tile_entity(startTile + Vector2i(x,-y)) != null:self.set_cell(startTile + Vector2i(x,-y), 11, Vector2i(3, 7))

func markTilesInLine(startTile : Vector2i, begin : int, end: int):
	for dist in range(begin, end):
		if Global.tileManager.get_tile_entity(startTile + Vector2i(dist, 0)) != null: self.set_cell(startTile + Vector2i(dist, 0), 11, Vector2i(3,7))
		if Global.tileManager.get_tile_entity(startTile + Vector2i(-dist,0)) != null:self.set_cell(startTile + Vector2i(-dist, 0), 11, Vector2i(3, 7))
		if Global.tileManager.get_tile_entity(startTile + Vector2i(0, dist)) != null:self.set_cell(startTile + Vector2i(0, dist), 11, Vector2i(3,7))
		if Global.tileManager.get_tile_entity(startTile + Vector2i(0, dist)) != null:self.set_cell(startTile + Vector2i(0, -dist), 11, Vector2i(3, 7))

func highlightpath(path: Array[Vector2i]):
	for point in path:
		self.set_cell(point, 11, Vector2i(2,7))

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

# 
func markTiles(startTile : Vector2i, begin : int, end: int):
	if end == 1:
		for x in range(begin, end + 1):
			for y in range(begin, end + 1):
				if x == end and  y == end:
					break
				self.set_cell(startTile + Vector2i(x, y), 11, Vector2i(3,7))
				self.set_cell(startTile - Vector2i(x,y), 11, Vector2i(3, 7))
				self.set_cell(startTile + Vector2i(-x, y), 11, Vector2i(3,7))
				self.set_cell(startTile + Vector2i(x,-y), 11, Vector2i(3, 7))
	else:
		for x in range(begin, end + 1):
			for y in range(begin, end + 1):
				if x + y == end:
					break
				self.set_cell(startTile + Vector2i(x, y), 11, Vector2i(3,7))
				self.set_cell(startTile - Vector2i(x,y), 11, Vector2i(3, 7))
				self.set_cell(startTile + Vector2i(-x, y), 11, Vector2i(3,7))
				self.set_cell(startTile + Vector2i(x,-y), 11, Vector2i(3, 7))


func highlightpath(path: Array[Vector2i]):
	for point in path:
		self.set_cell(point, 11, Vector2i(2,7))

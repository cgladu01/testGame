extends Node2D

var astargrid : AStarGrid2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	astargrid = AStarGrid2D.new()
	astargrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setMap(tileManager: TileManager):
	astargrid.size = Vector2i(tileManager.width, tileManager.height)
	astargrid.cell_size = Vector2(1, 1)
	astargrid.update()
	
	for x in tileManager.width:
		for y in tileManager.height:
			var terrain = tileManager.get_tile(Vector3i(x, y, 0))
			var entity = tileManager.get_tile(Vector3i(x, y, 1))
			if entity is Obstacle:
				astargrid.set_point_solid(Vector2i(x, y), true)
				

	tileManager.astar2Grid = astargrid
	pass
	

func updateMap(position: Vector2i, solid: int):
	astargrid.set_point_solid(position, solid)

func updateWeight(position: Vector2i, weight: float):
	astargrid.set_point_weight_scale(position, weight)

func getPath(start: Vector2i, end: Vector2i):
	return astargrid.get_point_path(start, end, true)

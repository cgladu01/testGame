extends Node2D

var astar2Grid : AStarGrid2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	astar2Grid = AStarGrid2D.new()
	astar2Grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setMap(tileManager: TileManager):
	astar2Grid.region = Rect2i(Vector2i(0,0), Vector2i(tileManager.width, tileManager.height))
	astar2Grid.cell_size = Vector2(1, 1)
	astar2Grid.update()
	
	for x in tileManager.width:
		for y in tileManager.height:
			var terrain = tileManager.get_tile(Vector3i(x, y, 0))
			var entity = tileManager.get_tile(Vector3i(x, y, 1))
			if terrain is Obstacle:
				print(str(x, " ", y))
				astar2Grid.set_point_solid(Vector2i(x, y), true)

	tileManager.astar2Grid = astar2Grid	

func updateMap(position: Vector2i, solid: int):
	astar2Grid.set_point_solid(position, solid)

func updateWeight(position: Vector2i, weight: float):
	astar2Grid.set_point_weight_scale(position, weight)


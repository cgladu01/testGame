class_name SplashAction extends TargetedAction

var patternNode : PatternNode = null

func hover_event(starting_tile : Vector2i, unhover: bool = false):
	patternNode.hover_event(starting_tile, find_rotation(starting_tile), unhover)

func click_event(starting_tile : Vector2i, unhover: bool = false):
	patternNode.click_event(starting_tile, find_rotation(starting_tile), unhover)

func validTarget(starttile: Tile, endtile: Tile, tileManager: TileManager) -> bool:
	return patternNode.verify_event(endtile.location, find_rotation(endTile.location))

func execute():
	super()

func canPlay():
	return super() and validTarget(startTile, endTile, Global.tileManager)

func find_rotation(start_tile: Vector2i) -> int:
	# Same x or y
	if start_tile.x == owner.location.x:
		# Up or down
		if start_tile.y >= owner.location.y:
			return 0
		else:
			return 2
	else:
		#Right or left
		if start_tile.x >= owner.location.x:
			return 1
		else:
			return 3
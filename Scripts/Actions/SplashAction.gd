class_name SplashAction extends Action

var patternNode : PatternNode = null

func validTargets(starttile: Tile, endtile: Array[Tile]) -> bool:
	return false

func hover_event(starting_tile : Vector2i, rotation : int, unhover: bool = false):
	patternNode.hover_event(starting_tile, rotation, unhover)

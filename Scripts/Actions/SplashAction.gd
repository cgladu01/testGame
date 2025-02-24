class_name SplashAction extends TargetedAction

var patternNode : PatternNode = null

func hover_event(starting_tile : Vector2i, rotation : int = 0, unhover: bool = false):
	patternNode.hover_event(starting_tile, rotation, unhover)


func click_event(starting_tile : Vector2i, rotation : int = 0, unhover: bool = false):
	patternNode.click_event(starting_tile, rotation, unhover)

func validTarget(starttile: Tile, endtile: Tile, tileManager: TileManager) -> bool:
	return patternNode.verify_event(endtile.location, 0)

func execute():
	if canPlay() and validTarget(startTile, endTile, Global.tileManager):
		patternNode.proccess_event(endTile, 0)


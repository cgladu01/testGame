class_name TargetedAction extends Action

var startTile: Tile = null
var endTile: Tile = null

func validTarget(starttiel : Tile, endtile: Tile, tileManager : TileManager) -> bool:
	return false


func button_pressed():
	pass

func canPlay():
	if super():
		return endTile != null
	return false 

class_name Move extends TargetedAction

var path : PackedVector2Array
var tileManager: TileManager = null

func setup(owner: Entities):
	name = "Move"
	super(owner)

func validTarget(starttile: Tile, endtile: Tile, tileManager: TileManager) -> bool:
	if not starttile or not endtile:
		return false
	startTile = starttile
	endTile = endtile
	path = tileManager.astar2Grid.get_id_path(startTile.location, endTile.location)
	self.tileManager = tileManager
	return path.size() != 0 and path.size() <= 5


func button_pressed():
	var function = func _button_pressed():
		Global.actionSelection(self)
		Global.selectionTile.markTiles(owner.location, 0, 5)
	return function

func execute():
	used = true
	tileManager.move_entity(startTile, endTile.location)
	owner.node.move_along_path(path)
	super()
	

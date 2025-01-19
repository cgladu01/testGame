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
	var potPath = tileManager.astar2Grid.get_id_path(startTile.location, endTile.location)
	
	if potPath.size() <= 5:
		path = potPath
		Global.selectionTile.markTiles(owner.location, 0, 5)
		Global.selectionTile.highlightpath(path)

	self.tileManager = tileManager
	return potPath.size() != 0 and potPath.size() <= 5


func button_pressed():
	Global.actionSelection(self)
	Global.selectionTile.markTiles(owner.location, 0, 5)

func execute():
	used = true
	tileManager.move_entity(startTile, endTile.location)
	owner.node.move_along_path(path)
	super()
	

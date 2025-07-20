class_name Move extends TargetedAction

var path : Array[Vector2i]
var tileManager: TileManager = null

func setup(owner: Character):
	cost = 0
	name = "Move"
	type = Global.card_type.ATTACK
	super(owner)

func validTarget(starttile: Tile, endtile: Tile, tileManager: TileManager) -> bool:
	if not starttile or not endtile or not endtile is EmptyTile:
		return false
	startTile = starttile
	self.tileManager = tileManager
	endTile = endtile
	var potPath = tileManager.getPath(startTile.location, endTile.location)
	
	if potPath.size() <= 5:
		path = potPath
		Global.selectionTile.markTiles(owner.location, 0, 5)
		Global.selectionTile.highlightpath(path)
	else:
		Global.selectionTile.clear()
		Global.selectionTile.markTiles(owner.location, 0, 5)

	return potPath.size() != 0 and potPath.size() <= 5


func button_pressed():
	Global.actionSelection(self)
	Global.selectionTile.markTiles(owner.location, 0, 5)

func execute():
	if canPlay():
		used = true
		owner.move_on_path(5, path)
		owner.moved = true
		super()
	

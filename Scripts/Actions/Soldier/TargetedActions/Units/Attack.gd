class_name Attack extends TargetedAction

var tileManager: TileManager = null

func setup(owner: Character):
	name = "Attack"
	description = "Attack 6"
	super(owner)

func validTarget(starttile: Tile, endtile: Tile, tileManager: TileManager) -> bool:
	if not starttile or not endtile:
		return false
	startTile = starttile
	endTile = endtile
	self.tileManager = tileManager
	return endTile is Enemy and tileManager.distance(startTile.location, endTile.location) <= 1


func button_pressed():
	Global.actionSelection(self)
	Global.selectionTile.markTiles(owner.location, 0, 1)

func execute():
	if canPlay():
		used = true
		var target = endTile as Enemy
		owner.attack(6, target)
		super()

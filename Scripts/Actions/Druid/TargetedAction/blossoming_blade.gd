class_name BlossomingBlade extends TargetedAction
var tileManager: TileManager = null

func setup(owner: Character):
	actionAttributes = load("res://Resources/Actions/Druid/TargetedAction/blossoming_blade.tres")
	cost = 1
	super(owner)

func button_pressed():
	Global.actionSelection(self)
	Global.selectionTile.markTiles(owner.location, 0, 1)

func validTarget(starttile: Tile, endtile: Tile, tileManager: TileManager) -> bool:
	if not starttile or not endtile:
		return false
	startTile = starttile
	endTile = endtile
	return endTile is Enemy and tileManager.distance(startTile.location, endTile.location) <= 1

func execute():
	if canPlay():
		used = true
		var target = endTile as Enemy
		owner.attack(8, target)
		owner.addStatus(Bud.new().setup_Status(3, owner), owner)
		owner.discardDeck.insertAtFront(self)
		super()

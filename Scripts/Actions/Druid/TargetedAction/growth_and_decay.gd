class_name GrowthAndDecay extends TargetedAction

func setup(owner: Character):
	actionAttributes = load("res://Resources/Actions/Druid/TargetedAction/growth_and_decay.tres")
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

func canPlay():
	if actionAttributes.type == Global.card_type.SKILL and owner.hasStatus("Silence") != null:
		return false

	if owner is Character:
		var character = owner as Character
		return character.energy - cost >= 0

func execute():
	if canPlay():
		if endTile is Enemy:
			var target = endTile as Enemy
			target.addStatus(Rot.new().setup_Status(2, target), owner)
		
		owner.accelerateAllStatuses(Status.StatusType.BUFF, 1)
		self.put_self_into_lost()
		super()

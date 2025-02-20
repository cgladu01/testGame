class_name ThornBarrage extends TargetedAction

func setup(owner: Entities):
    name = "Thorn Barrage"
    description = "Attack 6, Inflict 2 Bleed twice in a wall pattern within range 3."

    var behavior = func (endTile : Tile) : 
        if endTile is Enemy:
            var target = endTile as Enemy
            owner.attack(6, target)
            target.addStatus(Bleed.new().setup_Status(2, target), owner)


    var initial_pattern = PatternNode.new()
    initial_pattern.setup(behavior)

    var right_pattern = PatternNode.new()
    right_pattern.setup(behavior, null, null, null, initial_pattern)

    var left_pattern = PatternNode.new()
    left_pattern.setup(behavior, null, initial_pattern)

    super(owner)

func button_pressed():
    Global.actionSelection(self)
    Global.selectionTile.markTiles(owner.location, 0, 3)


func validTarget(starttile: Tile, endtile: Tile, tileManager: TileManager) -> bool:
    if not startTile or not endTile:
        return false
    
    return true

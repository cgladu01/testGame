class_name ThornBarrage extends SplashAction

func setup(owner: Entities):
    name = "Thorn Barrage"
    description = "Attack 6, Inflict 2 Bleed twice in a wall pattern within range 3."
    cost = 2
    var behavior = func (endTile : Tile) : 
        if endTile is Enemy:
            var target = endTile as Enemy
            owner.attack(6, target)
            target.addStatus(Bleed.new().setup_Status(2, target), owner)


    var initial_pattern = PatternNode.new()
    initial_pattern.setup(behavior)

    patternNode = initial_pattern

    var right_pattern = PatternNode.new()
    right_pattern.setup(behavior, null, null, null, initial_pattern)

    var left_pattern = PatternNode.new()
    left_pattern.setup(behavior, null, initial_pattern)

    super(owner)

func button_pressed():
    Global.actionSelection(self)
    Global.selectionTile.markTilesInLine(owner.location, 0, 4)


func validTarget(starttile: Tile, endtile: Tile, tileManager: TileManager) -> bool:
    startTile = starttile
    endTile = endtile

    if Global.tileManager.distance(startTile.location, endTile.location) > 3:
        return false
    elif  startTile.location.x != endTile.location.x and startTile.location.y != endTile.location.y:
        return false

    return super(starttile, endtile, tileManager)

func execute():
    if canPlay():
        patternNode.proccess_event(self.endTile, find_rotation(self.endTile.location))
        patternNode.proccess_event(self.endTile, find_rotation(self.endTile.location))

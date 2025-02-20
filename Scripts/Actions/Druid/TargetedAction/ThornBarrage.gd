class_name ThornBarrage extends TargetedAction

func setup(owner: Entities):
    name = "Thorn Barrage"
    description = "Attack 6, Inflict 2 Bleed twice in a triangle pattern within range 3."
    super(owner)

func button_pressed():
    Global.actionSelection(self)
    Global.selectionTile.markTiles(owner.location, 0, 3)


func validTarget(starttile: Tile, endtile: Tile, tileManager: TileManager) -> bool:
    if not startTile or not endTile:
        return false
    
    return true

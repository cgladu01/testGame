class_name Bash extends "res://Scripts/Actions/TargetedActions/TargetedAction.gd"
var tileManager: TileManager = null

func setup(owner: Entities):
    name = "Bash"
    super(owner)

func validTarget(starttile: Tile, endtile: Tile, tileManager: TileManager) -> bool:
    if not starttile or not endtile:
        return false
    startTile = starttile
    endTile = endtile
    self.tileManager = tileManager
    return endTile is Enemy and tileManager.distance(startTile.location, endTile.location) <= 1


func button_pressed():
    var function = func _button_pressed():
        Global.actionSelection(self)
        Global.selectionTile.markTiles(owner.location, 0, 1)
    return function

func execute():
    used = true
    var target = endTile as Enemy
    target.addStatus(Global.statusFactory.createStatus("Daze", 3))
    target.attack_damage(10, owner)
    super()
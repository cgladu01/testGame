extends Node

var rng : RandomNumberGenerator = null
var selection : bool = false
var currentAction : Action = null
var impassableList = []

var tileshift : Vector2 = Vector2(1,1)
var tileShift : Vector2i = Vector2i(1, 1)
var tileManager: TileManager = TileManager.new()

var statusFactory : StatusFactory = StatusFactory.new()
var characterFactory : CharacterFactory = CharacterFactory.new()
var actionFactory: ActionFactory = ActionFactory.new()
var enemyFactory : EnemyFactory = EnemyFactory.new()

var characters : Array[Character] = []
var enemies : Array[Enemy] = []
signal update_health
signal update_energy
signal update_status

var selectionTile : TileMapLayer

func actionSelection(selected_action: Action):
    selectionTile.clear()
    selection = !selection
    currentAction = selected_action
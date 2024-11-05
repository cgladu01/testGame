extends Node2D
@onready var playerNode: PlayerUnit = $Units/PlayerUnits/Player
@onready var world: Node2D = $"."
@onready var astar_2_grid: Node2D = $Astar2Grid
@onready var terrain: TileMapLayer = $Layerholder/terrain
@onready var selection: TileMapLayer = $Layerholder/selection
@onready var entities: TileMapLayer = $Layerholder/entities
@onready var enemyNode: UnitNode = $Units/EnemyUnits/Enemy
@onready var units: Node2D = $Units
var tileManager : TileManager = Global.tileManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.rng = RandomNumberGenerator.new()
	Global.rng.set_seed(0)
	Global.tileManager.setup([terrain, entities, selection] as Array[TileMapLayer], 70, 39, 3)
	astar_2_grid.setMap(tileManager)
	var player = Global.characterFactory.createCharacter("DudeMan", Vector2i(0,0), playerNode)
	Global.enemyFactory.createEnemy("Wolf", Vector2i(10,10), enemyNode)
	player.addStatus(Global.statusFactory.createStatus("Bleed", 1))
	units.turnOne()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func return_tileManager() -> TileManager:
	return tileManager

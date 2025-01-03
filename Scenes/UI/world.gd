extends Node2D

@onready var world: Node2D = $"."
@onready var astar_2_grid: Node2D = $Astar2Grid
@onready var terrain: TileMapLayer = $Layerholder/terrain
@onready var selection: TileMapLayer = $Layerholder/selection
@onready var entities: TileMapLayer = $Layerholder/entities
@onready var units: Node2D = $Units
@onready var canvas: CanvasLayer = $CanvasLayer
@onready var log_container = $CanvasLayer/LogContainer
var tileManager : TileManager = Global.tileManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.selectionTile = selection
	Global.rng = RandomNumberGenerator.new()
	Global.unitsNode = units
	Global.rng.set_seed(0)
	Global.tileManager.setup([terrain, entities, selection] as Array[TileMapLayer], 70, 39, 3)
	Global.log_container = log_container

	astar_2_grid.setMap(tileManager)
	var player = Global.characterFactory.createCharacter("DudeMan", Vector2i(0,0))
	Global.enemyFactory.createEnemy("Wolf", Vector2i(10,10))
	Global.enemyFactory.createEnemy("Wolf", Vector2i(5,5))
	units.turnOne()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func return_tileManager() -> TileManager:
	return tileManager

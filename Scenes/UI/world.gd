extends Node2D

@onready var world: Node2D = $"."
@onready var astar_2_grid: Node2D = $Astar2Grid
@onready var selection: TileMapLayer = $Layerholder/selection
@onready var units: Node2D = $Units
@onready var canvas: CanvasLayer = $CanvasLayer
@onready var log_container = $CanvasLayer/LogContainer
@onready var layerholder = $Layerholder
var tileManager : TileManager = Global.tileManager

var rewardScreen = preload("res://Scenes/Menu/RewardScreens/RewardsScreen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.selectionTile = selection
	Global.rng = RandomNumberGenerator.new()
	Global.unitsNode = units
	Global.rng.set_seed(0)
	seed(0)
	Global.log_container = log_container
	generateLevel(Global.level_number)
	Global.combatEnd.connect(_on_combatEnd)

func _on_combatEnd():
	canvas.add_child(rewardScreen.instantiate())


func generateLevel(level_number: int):
	layerholder.generate_level(level_number)
	astar_2_grid.setMap(tileManager)
	units.turnOne()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func return_tileManager() -> TileManager:
	return tileManager

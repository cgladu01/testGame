extends Node2D

@onready var world: Node2D = $"."
@onready var astar_2_grid: Node2D = $Astar2Grid
@onready var selection: TileMapLayer = $Layerholder/selection
@onready var units: Node2D = $Units
@onready var canvas: CanvasLayer = $CanvasLayer
@onready var log_container = $CanvasLayer/LogContainer
@onready var layerholder = $Layerholder
@onready var layoutMap = $CanvasLayer/LayoutMap
var tileManager : TileManager = Global.tileManager

# Reward Handling after combat completion
var rewardhandler : RewardHandler = RewardHandler.new()
var rewardScreen : RewardScreen = null

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
	layoutMap.generateMap()
	Global.level_changed.connect(_level_changed)
	Global.canvas_layer = canvas
	rewardhandler.setup(canvas)

func _on_combatEnd():
	rewardScreen = rewardhandler.generateRewards()

func _level_changed():
	if rewardScreen != null:
		rewardScreen.queue_free()
		rewardScreen = null
	generateLevel(Global.level_number)

func changeRoom(new_room : RoomIcon):
	if Global.currentRoom.completed:
		Global.currentRoom = new_room
		Global.currentRoom.behavior.call()

func generateLevel(level_number: int):
	layerholder.generate_level(level_number)
	astar_2_grid.setMap(tileManager)
	units.turnOne()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func return_tileManager() -> TileManager:
	return tileManager

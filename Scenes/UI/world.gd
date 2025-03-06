extends Node2D

@onready var world: Node2D = $"."
@onready var astar_2_grid: Node2D = $Astar2Grid
@onready var selection: TileMapLayer = $Layerholder/selection
@onready var units: Node2D = $Units
@onready var canvas: CanvasLayer = $CanvasLayer
@onready var log_container = $CanvasLayer/LogContainer
@onready var layerholder = $Layerholder
@onready var layoutMap = $LayoutMap
var tileManager : TileManager = Global.tileManager

var rewardScreenScene = preload("res://Scenes/Menu/RewardScreens/RewardsScreen.tscn")
var rewardItemScene = preload("res://Scenes/Menu/RewardScreens/Reward_item.tscn")
var card_reward_scene = preload("res://Scenes/Menu/RewardScreens/card_reward_screen.tscn")

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

func _on_combatEnd():
	var rewardScreen = rewardScreenScene.instantiate()
	canvas.add_child(rewardScreen)
	var rewardItem = rewardItemScene.instantiate()
	rewardScreen.addReward(rewardItem)
	rewardItem.setup(generateCardRewardBehavior(), "Card Reward")


func generateCardRewardBehavior() -> Callable:
	var actions: Array[Action] = []

	for x in range(Global.card_reward_count):
		actions.append(Global.actionFactory.createRandomAction(Global.characters[0]))

	return 	func ():
		var card_reward = card_reward_scene.instantiate()
		canvas.add_child(card_reward)
		card_reward.displayActions(actions)

func generateLevel(level_number: int):
	layerholder.generate_level(level_number)
	astar_2_grid.setMap(tileManager)
	units.turnOne()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func return_tileManager() -> TileManager:
	return tileManager

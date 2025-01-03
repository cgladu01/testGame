extends Node2D
@onready var playerUnits : Node2D = $"PlayerUnits"
@onready var enemyUnits : Node2D = $"EnemyUnits"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../CanvasLayer/Control/PanelContainer/HBoxContainer/EndTurn".EndTurnPlayerTurn.connect(_onEndTurn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func turnOne():
	Global.hapFactory.createStartOfRoundHap(1)
	for enemy in Global.enemies:
		enemy.setup_turn()

func _onEndTurn():
	for character in Global.characters:
		character.roundEnd()

	for x in $PlayerUnits.get_children():
		if x is CharacterNode:
			x.refresh_Actions()
	
	for enemy in Global.enemies:
		enemy.roundStart()

	for enemy in Global.enemies:
		enemy.do_Turn()

	for enemy in Global.enemies:
		enemy.roundEnd()

	for enemy in Global.enemies:
		enemy.setup_turn()
	
	for character in Global.characters:
		character.roundStart()

func clearActionLine():
	for x in enemyUnits.get_children():
		if x is EntitiyNode:
			x.clearActionLine()

func displayAllActionLine():
	for x in enemyUnits.get_children():
		if x is EntitiyNode:
			x.dispActionline()

func _on_enemy_foresight_button_down() -> void:
	displayAllActionLine()

func _on_enemy_foresight_button_up() -> void:
	clearActionLine()

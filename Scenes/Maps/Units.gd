extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../CanvasLayer/Control/PanelContainer/EndTurn".EndTurnPlayerTurn.connect(_onEndTurn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func turnOne():
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

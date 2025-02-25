extends Node2D
@onready var playerUnits : Node2D = $"PlayerUnits"
@onready var enemyUnits : Node2D = $"EnemyUnits"
# Holds other entities and handles whose turn it is and roundstart/roundend shenanigans

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../CanvasLayer/Control/PanelContainer/HBoxContainer/VBoxContainer/EndTurn".EndTurnPlayerTurn.connect(_onEndTurn)
	Global.entityDeath.connect(_on_entity_death)
	Global.characterDeath.connect(_on_character_death)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func turnOne():
	Global.hapFactory.createStartOfRoundHap(1)
	Global.combatStart.emit()
	for character in Global.characters:
		character.combatStart()

	for enemy in Global.enemies:
		enemy.combatStart()

	for character in Global.characters:
		character.roundStart()
	Global.roundStart.emit()

	for enemy in Global.enemies:
		enemy.roundStart()

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
	Global.roundStart.emit()

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

func _on_entity_death():
	for i in range(0, Global.enemies.size()):
		var enemy : Entities = Global.enemies[i]
		if enemy.get_health() == 0:
			enemy.node.queue_free()
			Global.enemies.remove_at(i)
			if Global.enemies.size() == 0:
				Global.combatActive = false
				Global.combatEnd.emit()
			break


# Plan to make lose on any character death so will have to make a lose screen
func _on_character_death():
	pass

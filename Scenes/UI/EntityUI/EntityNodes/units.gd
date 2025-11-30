extends Node2D
@onready var playerUnits : Node2D = $"PlayerUnits"
@onready var enemyUnits : Node2D = $"EnemyUnits"
# Holds other entities and handles whose turn it is and roundstart/roundend shenanigans

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../CanvasLayer/Control/PanelContainer/HBoxContainer/VBoxContainer/EndTurn".EndTurnPlayerTurn.connect(_on_end_turn)
	Global.entityDeath.connect(_on_entity_death)
	Global.characterDeath.connect(_on_character_death)
	Global.entityMoved.connect(_on_entity_moved)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func turn_one():
	Global.combatStart.emit()
	Global.hapFactory.createStartOfRoundHap(1)
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

func _on_end_turn():
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

func clear_action_line():
	for x in enemyUnits.get_children():
		if x is EntitiyNode:
			x.clear_action_line()

func display_all_actions_lines():
	for x in enemyUnits.get_children():
		if x is EntitiyNode:
			x.show_targeting()
			x.dispActionline()

func _on_enemy_foresight_button_down() -> void:
	display_all_actions_lines()

func _on_enemy_foresight_button_up() -> void:
	# Global.end_preview.emit()
	clear_action_line()

func display_targeting(real_location: bool = true):
	for x in enemyUnits.get_children():
		if x is EntitiyNode:
			x.show_targeting(real_location)

func _on_entity_death():
	for i in range(0, Global.enemies.size()):
		var enemy : Entities = Global.enemies[i]
		if enemy.get_health() == 0:
			enemy.node.queue_free()
			Global.enemies.remove_at(i)
			if Global.enemies.size() == 0:
				Global.combatActive = false
				Global.currentRoom.set_completed()
				for character in Global.characters:
					character.combatEnd()
				Global.combatEnd.emit()
			break


func _on_entity_moved():
	for character in Global.characters:
		for status in character.onNearMovementStatuses:
			status.nearMoveEffect(Global.moved_entity)
	
	for enemy in Global.enemies:
		for status in enemy.onNearMovementStatuses:
			status.nearMoveEffect(Global.moved_entity)


# Plan to make lose on any character death so will have to make a lose screen
func _on_character_death():
	pass

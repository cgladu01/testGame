# This class is responsible for setting up the levels and creating the corresponding entities/characters for it.
extends Node2D
var currentlevel = null
var card_reward_scene = preload("res://Scenes/Menu/RewardScreens/card_reward_screen.tscn")
@onready var canvas_layer = $"../CanvasLayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GDConsole.create_command(kill_all_enemies)
	GDConsole.create_command(generate_card_rewards)
	GDConsole.create_command(give_character_action)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# This is called from world and makes the level depening on the number provided.
func generate_level(level_number: int):
	currentlevel = load(str("res://Scenes/Maps/LDTK/levels/Level_", level_number, ".scn")).instantiate()
	self.add_child(currentlevel)
	self.move_child(currentlevel, 0)
	Global.tile_map_layer = currentlevel.get_child(0)
	var entities: LDTKEntityLayer = null
	for child in currentlevel.get_children():
		if str(child.name) == "Entities":
			entities = child
			break
		
	Global.tileManager.setup([Global.tile_map_layer, Global.selectionTile] as Array[TileMapLayer], 21, 16, 2)
	
	for entity in entities.get_children():
		entities.remove_child(entity)
		
		if entity is CharacterNode:
			var characterNode: CharacterNode = entity as CharacterNode
			if Global.characterNames[characterNode.get_meta("number") - 1] != "" and Global.characters.size() < 2:
				Global.characterFactory.createCharacter(Global.characterNames[characterNode.get_meta("number") - 1], characterNode)
			else:
				characterNode.queue_free()
		else:
			Global.enemyFactory.createEnemy("Wolf", entity as EntitiyNode)
	
	entities.queue_free()

func kill_all_enemies():
	while not Global.enemies.is_empty():
		var enemy = Global.enemies.front()
		enemy.set_health(0)
		enemy.change_health(0)

func generate_card_rewards(actionNames_str: String):
	var actionNames = str_to_var(actionNames_str)
	var actions : Array[Action] = []

	for action in actionNames:
		actions.append(Global.actionFactory.createAction(action, Global.characters.front()))
	
	var card_reward = card_reward_scene.instantiate()
	canvas_layer.add_child(card_reward)
	card_reward.displayActions(actions)

func give_character_action(actionName: String, ownerName: String):
	for character in Global.characters:
		if character.name == ownerName:
			character.hand.addAction(Global.actionFactory.createAction(actionName, character))
			break


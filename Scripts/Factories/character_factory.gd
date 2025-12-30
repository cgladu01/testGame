class_name CharacterFactory

var basic_actions : Array[String] = ["Attack", "Defend"]
var characterNode = preload("res://Scenes/UI/EntityUI/EntityNodes/character_node.tscn")

func createCharacter(name: String, start_node: CharacterNode) -> Character:
	if Global.unitsNode:
		Global.unitsNode.playerUnits.add_child(start_node)

	var character : Character = Character.new()
	var starter_deck : Array[Action] =  []
	var character_attributes : CharacterAttributes = CharacterAttributes.new()

	for x in basic_actions:
		for y in range(0, 4):
			starter_deck.append(Global.actionFactory.createAction(x, character))

	var start_health = 0
	match name:
		"DudeMan":
			start_health = 100
			character_attributes = load("res://Resources/Entities/Character/dudeMan.tres")
			starter_deck.append(Global.actionFactory.createAction("Bash", character))

		"Druid":
			start_health = 100
			character_attributes = load("res://Resources/Entities/Character/druid.tres")
			starter_deck.append(Global.actionFactory.createAction("Bash", character))
			starter_deck.append(Global.actionFactory.createAction("Thorn Barrage", character))
		_:
			start_health = 10

	character.setup_character(starter_deck, start_health, Global.tile_map_layer.local_to_map(start_node.position), start_node, character_attributes)
	Global.tileManager.change_tile_entity(character, character.location)
	Global.characters.append(character)
	return character

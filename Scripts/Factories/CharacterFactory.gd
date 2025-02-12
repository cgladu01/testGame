class_name CharacterFactory

var basic_actions : Array[String] = ["Attack", "Defend"]
var characterNode = preload("res://Scenes/Maps/CharacterNode.tscn")

func createCharacter(name: String, start_node: CharacterNode) -> Character:
	if Global.unitsNode:
		Global.unitsNode.playerUnits.add_child(start_node)

	var character : Character = Character.new()
	var starter_deck : Array[Action] =  []
	var mini_portrait : String = ""

	for x in basic_actions:
		for y in range(0, 4):
			starter_deck.append(Global.actionFactory.createAction(x, character))

	var start_health = 0
	match name:
		"DudeMan":
			start_health = 100
			mini_portrait = "res://icons/789_Lorc_RPG_icons/Icons8_32.png"
			starter_deck.append(Global.actionFactory.createAction("Bash", character))
		_:
			start_health = 10

	character.setup_character(name, starter_deck, start_health, Global.tile_map_layer.local_to_map(start_node.position), start_node, mini_portrait)
	Global.tileManager.change_tile_entity(character, character.location)
	Global.characters.append(character)
	return character

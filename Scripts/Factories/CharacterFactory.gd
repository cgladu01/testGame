class_name CharacterFactory

var basic_actions : Array[String] = ["Attack", "Move", "Rest"]

func createCharacter(name: String, location: Vector2i, start_node : CharacterNode) -> Character:
	var character : Character = Character.new()
	var actions : Array[Action] =  []
	var mini_portrait : String = ""

	for x in basic_actions:
		actions.append(Global.actionFactory.createAction(x, character))

	var start_health = 0
	match name:
		"DudeMan":
			start_health = 100
			mini_portrait = "res://icons/789_Lorc_RPG_icons/Icons8_32.png"
			actions.append(Global.actionFactory.createAction("Bash", character))
		_:
			start_health = 10

	character.setup_character(name, actions, start_health, location, start_node, mini_portrait)
	Global.tileManager.change_tile_entity(character, character.location)
	Global.characters.append(character)
	return character

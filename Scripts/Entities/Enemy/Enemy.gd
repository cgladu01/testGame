class_name Enemy extends Entities
var performed_actions : Array[EnemyActions] = []
var turn_actions : Array[EnemyActions] = []
var action: EnemyActions = null
var path : Array[Vector2i]

func get_actions() -> Array[EnemyActions]:
	return turn_actions

func setup_turn():
	pass

func setup_enemy(init_name : String, start_health : int, start_location : Vector2i, start_node : EntitiyNode, mini_portrait_path : String) -> void:
	name = init_name
	turn_actions = []
	miniPortaitPath = mini_portrait_path
	setup_entity(start_health, start_location, init_name, start_node)
	start_node.set_entity(self)

func do_Turn():
	action.execute()
	performed_actions.append(action)
	pass


func find_closest_player() -> Character:
	path = []
	var rcharacter = null
	for character in Global.characters:
		Global.tileManager.astar2Grid.set_point_solid(character.location, false)
		var newPath = Global.tileManager.astar2Grid.get_id_path(location, character.location, true)
		if path.size() > newPath.size() or path.size() == 0:
			path = newPath
			rcharacter = character
		Global.tileManager.astar2Grid.set_point_solid(character.location)
	
	path.pop_back()
	return rcharacter

func _init() -> void:
	pass

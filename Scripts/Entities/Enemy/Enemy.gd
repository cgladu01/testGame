class_name Enemy extends Entities
var actions : Array[EnemyActions] = []
var turn_actions : Array[EnemyActions] = []
var path : Array[Vector2i]

func get_actions() -> Array[EnemyActions]:
	return actions

func setup_turn():
	turn_actions.clear()

func setup_enemy(init_name : String, start_health : int, start_location : Vector2i, start_node : EntitiyNode, mini_portrait_path : String) -> void:
	name = init_name
	actions = []
	miniPortaitPath = mini_portrait_path
	setup_entity(start_health, start_location, init_name, start_node)
	start_node.set_entity(self)

func do_Turn():
	var target = find_closest_player()
	node.move_along_path(path)
	Global.tileManager.move_entity(self, path.back())
	target.attack_damage(30, self)
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

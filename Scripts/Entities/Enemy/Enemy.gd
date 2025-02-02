class_name Enemy extends Entities
var performed_actions : Array[EnemyActions] = []
var turn_actions : Array[EnemyActions] = []
var action: EnemyActions = null
var path : Array[Vector2i]

func get_actions() -> Array[EnemyActions]:
	return turn_actions

func setup_turn():
	if node != null and node.actionLine != null:
		node.dispActionline()
	pass

func setup_enemy(init_name : String, start_health : int, start_location : Vector2i, start_node : EntitiyNode, mini_portrait_path : String) -> void:
	name = init_name
	turn_actions = []
	miniPortaitPath = mini_portrait_path
	setup_entity(start_health, start_location, init_name, start_node)

func do_Turn():
	action.execute()
	pass


func find_closest_player() -> Character:
	path = []
	var rcharacter = null
	for character in Global.characters:
		var endTile = Global.tileManager.find_closet_open_tile(location, character.location, 2, false)
		var newPath = Global.tileManager.astar2Grid.getPath(location, endTile, 1)
		if path.size() > newPath.size() or path.size() == 0:
			path = newPath
			rcharacter = character

	return rcharacter

func do_enemy_move(dist : int):
	for x in range(path.size() - 1, 0, -1):
		if x <= dist and Global.tileManager.get_tile_entity(path[x]) is EmptyTile:
			move_on_path(x, path)




	
func _init() -> void:
	pass

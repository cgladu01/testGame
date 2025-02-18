class_name Enemy extends Entities
var performed_actions : Array[EnemyActions] = []
var turn_actions : Array[EnemyActions] = []
var action: EnemyActions = null
var path : Array[Vector2i]

func get_actions() -> Array[EnemyActions]:
	return turn_actions

# Pick turn from set of actions
# Must implement the actual picking in subclasses
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

# Find closets player
func find_closest_player() -> Character:
	path = []
	var rcharacter = null
	for character in Global.characters:
		if Global.tileManager.distance(character.location,location) == 1:
			rcharacter = character
			break
		var endTile = Global.tileManager.find_closet_open_tile(location, character.location, 1, false)
		var newPath = Global.tileManager.getPath(location, endTile, 1)
		if path.size() > newPath.size() or path.size() == 0:
			path = newPath
			rcharacter = character

	return rcharacter

func do_enemy_move(dist : int):
	if path.size() != 0 and Global.tileManager.get_tile_entity(path[min(dist - 1, path.size() - 1)]) is EmptyTile:
		move_on_path(dist, path)




	
func _init() -> void:
	pass

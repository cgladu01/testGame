class_name EnemyMoveEngine
#This class handles moves for all enemies.

enum ACTION_TYPE {RANGED, MELEE, FLEEING}


func find_closest_player(enemy : Enemy, real_location : bool = true, type: EnemyMoveEngine.ACTION_TYPE = ACTION_TYPE.MELEE, range: int = 0) -> Dictionary:
	var path : Array[Vector2i] = []
	var target = null
	var locations = Global.characters.map(func(character) -> Vector2i: return character.location) if (real_location) else Global.mock_locations
	for x in range(0, locations.size()):
		if not Global.tileManager.isOnboard(locations[x]):
			continue
		match type:
			ACTION_TYPE.MELEE:
				if Global.tileManager.distance(locations[x] as Vector2i,enemy.location) == 1:
					target = Global.characters[x]
					break
				var endTile = Global.tileManager.find_closet_open_tile(enemy.location, locations[x] as Vector2i, 1, false)
				var newPath = Global.tileManager.getPath(enemy.location, endTile, 1)
				if path.size() > newPath.size() or path.size() == 0:
					path = newPath
					target = Global.characters[x]
	
	return {"path": path, "target": target}

func do_move_along_path(enemy: Enemy, path: Array[Vector2i], dist : int):
	if path.size() != 0 and Global.tileManager.get_tile_entity(path[min(dist - 1, path.size() - 1)]) is EmptyTile:
		enemy.move_on_path(dist, path)

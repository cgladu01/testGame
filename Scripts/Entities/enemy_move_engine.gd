class_name EnemyMoveEngine
#This class handles moves for all enemies.

enum ACTION_TYPE {RANGED, MELEE, FLEEING}


func find_closest_player(enemy : Enemy, type: EnemyMoveEngine.ACTION_TYPE = ACTION_TYPE.MELEE, range: int = 0) -> Dictionary:
    var path = []
    var target = null
    for character in Global.characters:
        match type:
            ACTION_TYPE.MELEE:
                if Global.tileManager.distance(character.location,enemy.location) == 1:
                    target = character
                    break
                var endTile = Global.tileManager.find_closet_open_tile(enemy.location, character.location, 1, false)
                var newPath = Global.tileManager.getPath(enemy.location, endTile, 1)
                if path.size() > newPath.size() or path.size() == 0:
                    path = newPath
                    target = character
    
    return {"path": path, "target": target}

func do_move_along_path(enemy: Enemy, path: Array[Vector2i], dist : int):
    if path.size() != 0 and Global.tileManager.get_tile_entity(path[min(dist - 1, path.size() - 1)]) is EmptyTile:
        enemy.move_on_path(dist, path)

class_name Wolf extends Enemy

func get_actions() -> Array[Action]:
    return actions

func setup_turn():
    turn_actions.clear()
    turn_actions.append(actions[1])

func do_Turn():
    var target = find_closest_player()
    node.move_along_path(path)
    Global.tileManager.move_entity(self, path.back())
    target.attack_damage(30, self)

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
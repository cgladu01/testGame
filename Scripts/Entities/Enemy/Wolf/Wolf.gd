class_name Wolf extends Enemy

func setup_turn():
    action = turn_actions[2]

func setup_enemy(init_name : String, start_health : int, start_location : Vector2i, start_node : EntitiyNode, mini_portrait_path : String) -> void:
    super(init_name, start_health, start_location, start_node, mini_portrait_path)
    turn_actions = [Rend.new(), Bite.new(), Howl.new()]
    for x in turn_actions:
        x.setup(self)

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
class_name Wolf extends Enemy

func setup_turn():
    if action is Howl:
        action = turn_actions.slice(0,3)[Global.rng.rand_weighted(PackedFloat32Array([1, 1]))]
    else:
        action = turn_actions[Global.rng.rand_weighted(PackedFloat32Array([0.5, 1, 1]))]
    super()

func setup_enemy(init_name : String, start_health : int, start_location : Vector2i, start_node : EntitiyNode, mini_portrait_path : String) -> void:
    super(init_name, start_health, start_location, start_node, mini_portrait_path)
    turn_actions = [Rend.new(), Bite.new(), Howl.new()]
    for x in turn_actions:
        x.setup(self)

func _init() -> void:
    pass
class_name Rend extends EnemyActions
const BASE_MOVE_VALUE = 4
const BASE_ATTACK_VALUE = 10

func setup(owner: Enemy):
    add_action_pair("res://icons/789_Lorc_RPG_icons/Icon.1_29.png", BASE_MOVE_VALUE )
    add_action_pair("res://icons/789_Lorc_RPG_icons/Icon.1_19.png", BASE_ATTACK_VALUE)
    name = "Rend"
    super(owner)

func execute():
    var result = Global.enemyMoveEngine.find_closest_player(owner)
    var target = result["target"]
    owner.path = result["path"]
    Global.enemyMoveEngine.do_move_along_path(owner, owner.path, BASE_MOVE_VALUE)
    if Global.tileManager.distance(owner.location, target.location) <= 1:
        owner.attack(10, target)
        target.addStatus(Bleed.new().setup_Status(1, target), owner)

func attack_value():
    return BASE_ATTACK_VALUE

func get_target():
    var result = Global.enemyMoveEngine.find_closest_player(owner)
    return result["target"] if result["path"].size() <= BASE_MOVE_VALUE else null

func statuses():
    return [Bleed.new().setup_Status(1, null)]
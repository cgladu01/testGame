class_name Rend extends EnemyActions

func setup(owner: Enemy):
    imageIndicator.append("res://icons/789_Lorc_RPG_icons/Icon.1_29.png")
    imageIndicator.append("res://icons/789_Lorc_RPG_icons/Icon.1_19.png")
    name = "Rend"
    super(owner)

func execute():
    var result = Global.enemyMoveEngine.find_closest_player(owner)
    var target = result[1]
    owner.path = result[0]
    Global.enemyMoveEngine.owner.do_enemy_move(4)
    if Global.tileManager.distance(owner.location, target.location) <= 1:
        owner.attack(10, target)
        target.addStatus(Bleed.new().setup_Status(1, target), owner)

func attack_value():
    return 10

func get_target():
    return Global.enemyMoveEngine.find_closest_player(owner)[1]
    
func statuses():
    return [Bleed.new().setup_Status(1, null)]
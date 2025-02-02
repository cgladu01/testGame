class_name Bite extends EnemyActions

func setup(owner: Enemy):
    imageIndicator.append("res://icons/789_Lorc_RPG_icons/Icon.1_29.png")
    imageIndicator.append("res://icons/789_Lorc_RPG_icons/Icon.1_55.png")
    name = "Bite"
    super(owner)

func execute():
    var target = owner.find_closest_player()
    owner.do_enemy_move(4)
    if Global.tileManager.distance(owner.location, target.location) <= 1:
        owner.attack(20, target)

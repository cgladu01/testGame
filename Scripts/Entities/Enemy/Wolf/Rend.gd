class_name Rend extends EnemyActions

func setup(owner: Enemy):
    imageIndicator.append("res://icons/789_Lorc_RPG_icons/Icon.1_29.png")
    imageIndicator.append("res://icons/789_Lorc_RPG_icons/Icon.1_19.png")
    name = "Rend"
    super(owner)

func execute():
    var target = owner.find_closest_player()
    owner.move_on_path(4, owner.path)
    if Global.tileManager.distance(owner.location, target.location) <= 1:
        owner.attack(10, target)
        target.addStatus(Bleed.new().setup_Status(1), owner)

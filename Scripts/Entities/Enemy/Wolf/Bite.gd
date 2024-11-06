class_name Bite extends EnemyActions

func setup(owner: Enemy):
    name = "Bite"
    super(owner)

func execute():
    var target = owner.find_closest_player()
    owner.move_on_path(4)
    if Global.tileManager.distance(owner.location, target.location) <= 1:
        owner.attack(20, target)

class_name Rend extends EnemyActions

func setup(owner: Enemy):
    name = "Rend"
    super(owner)

func execute():
    var target = owner.find_closest_player()
    owner.move_on_path(4)
    if Global.tileManager.distance(owner.location, target.location) <= 1:
        owner.attack(10, target)
        target.addStatus(Bleed.new().setup_Status(1))

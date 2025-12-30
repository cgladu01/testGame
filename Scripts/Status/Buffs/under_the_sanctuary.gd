class_name UnderTheSanctuary extends Status

var sanctuary_owner : Entities = null

func setup_Status(start_count : int, new_owner: Entities) -> Status:
    status_attributes = load(RESOURCE_PATH + "Buffs/under_the_sanctuary.tres")
    return super(start_count, new_owner)

func set_sanctuary_owner(n_sanctuary_owner: Entities):
    sanctuary_owner = n_sanctuary_owner
    return self    

func roundStart():
    owner.removeStatus(self)

func moveEffect(distance: int):
    if Global.tileManager.distance(sanctuary_owner.location, owner.location) > sanctuary_owner.hasStatus("Sanctuary").count:
        owner.removeStatus(self)

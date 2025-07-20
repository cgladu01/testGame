class_name UnderTheSanctuary extends Status

var sanctuary_owner : Entities = null

func setup_Status(start_count : int, new_owner: Entities) -> Status:
    image_path = "res://icons/789_Lorc_RPG_icons/Icon.3_17.png"
    name = "Under The Sanctuary"
    return super(start_count, new_owner)

func set_sanctuary_owner(n_sanctuary_owner: Entities):
    sanctuary_owner = n_sanctuary_owner
    return self    

func roundStart():
    owner.removeStatus(self)

func moveEffect(distance: int):
    if Global.tileManager.distance(sanctuary_owner.location, owner.location) > sanctuary_owner.hasStatus("Sanctuary").count:
        owner.removeStatus(self)

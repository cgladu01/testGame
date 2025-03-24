class_name SplinteringShieldStatus extends Status

func setup_Status(start_count : int, new_owner: Entities) -> Status:
    image_path = "res://icons/789_Lorc_RPG_icons/Icon.2_52.png"
    name = "Splintering Shield"
    return super(start_count, new_owner)

func roundStart():
    owner.removeStatus(self)

func brokenBlockEffect():
    for entities in Global.tileManager.get_entities_within(owner.location, 1, 1):
        entities.attack_damage(count, owner)
    owner.removeStatus(self)

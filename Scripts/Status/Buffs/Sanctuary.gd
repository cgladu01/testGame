class_name Sanctuary extends Status

var sanctuaried: Array[Entities] = []

func setup_Status(start_count : int, new_owner: Entities) -> Status:
    image_path = "res://icons/789_Lorc_RPG_icons/Icon.5_72.png"
    name = "Sanctuary"
    return super(start_count, new_owner)

func roundStart():
    owner.removeStatus(self)

func nearMoveEffect(entity: Entities):
    if entity == owner:
        return

    if Global.tileManager.distance(owner.location, entity.location) <= self.count:
        if owner is Character and entity is Character:
            sanctuaried.append(entity)
            entity.addStatus(UnderTheSanctuary.new().setup_Status(1, entity).set_sanctuary_owner(owner), owner)
        elif entity is Enemy and owner is Enemy:
            sanctuaried.append(entity)
            entity.addStatus(UnderTheSanctuary.new().setup_Status(1, entity).set_sanctuary_owner(owner), owner)

func underTheSanctuary(entity: Entities):
        sanctuaried.append(entity)
        entity.addStatus(UnderTheSanctuary.new().setup_Status(1, entity).set_sanctuary_owner(owner), owner)

func moveEffect(distance: int):
    for entity in sanctuaried:
        if Global.tileManager.distance(entity.location, owner.location) > count:
            entity.removeStatus(entity.hasStatus("Under The Sanctuary"))


class_name EquipmentFactory

func createEquipment(equipment_name: String):
    var returner = Equipment.new()
    returner.setup_equipment(load("res://Resources/Equipment/heirloom_shield.tres"))

    return returner
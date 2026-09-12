class_name EquipmentFactory

func createEquipment(equipment_name: String):

    var returner = Equipment.new()
    match equipment_name:
        "Heirloom Shield": 
            returner.setup_equipment(load("res://Resources/Equipment/heirloom_shield.tres"))
        "Cracked Pendant":
            returner.setup_equipment(load("res://Resources/Equipment/cracked_pendant.tres"))

    return returner
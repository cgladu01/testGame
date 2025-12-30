class_name Daze extends "res://Scripts/Status/status.gd"

func setup_Status(start_count : int, new_owner: Entities):
    status_attributes = load(RESOURCE_PATH + "Debuffs/daze.tres")
    type = StatusType.DEBUFF
    return super(start_count, new_owner)


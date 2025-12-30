class_name Strength extends "res://Scripts/Status/status.gd"


func setup_Status(start_count : int, new_owner: Entities):
    status_attributes = load(RESOURCE_PATH + "Buffs/strength.tres")
    return super(start_count, new_owner)


func attackEffectAdd(incoming: int, attacker: Entities, target: Entities) -> int:
    incoming += count
    return incoming 
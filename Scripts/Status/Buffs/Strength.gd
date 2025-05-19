class_name Strength extends "res://Scripts/Status/Status.gd"


func setup_Status(start_count : int, new_owner: Entities):
    image_path = "res://icons/789_Lorc_RPG_icons/Icon.3_10.png"
    name = "Strength"
    return super(start_count, new_owner)


func attackEffectAdd(incoming: int, attacker: Entities, target: Entities) -> int:
    incoming += count
    return incoming 
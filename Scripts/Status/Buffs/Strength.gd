class_name Strength extends "res://Scripts/Status/Status.gd"


func setup_Status(start_count : int):
    image_path = "res://icons/789_Lorc_RPG_icons/Icon.3_10.png"
    count = start_count

func attackEffect(incoming: int, attacker: Entities, target: Entities):
    incoming += count  
class_name Evasion extends Status

func setup_Status(start_count : int, new_owner: Entities) -> Status:
    image_path = "res://icons/789_Lorc_RPG_icons/Icon.1_29.png"
    name = "Evasion"
    return super(start_count, new_owner)


func onTargetStatusMult(damage: int, attacker: Entities):
    return 0

func roundStart():
    count = 0
    owner.removeStatus(self)
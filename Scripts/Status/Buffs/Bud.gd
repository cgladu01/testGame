class_name Bud extends "res://Scripts/Status/UnStackableStatus.gd"


func setup_Status(start_count : int, new_owner: Entities) -> Status:
    image_path = "res://icons/789_Lorc_RPG_icons/Icon.2_52.png"
    name = "Bud"
    return super(3, new_owner)

func roundStart():
    print("Dubshoe")
    decrementCount(1)
    if count == 0:
        pass
        # Gain the Flower Buff

func decrementCount(times: int = 1):
    count = count - times
    if count == 0:
        owner.removeStatus(self)
        pass
        # Gain the Flower Buff

func brokenBlockEffect():
    owner.removeStatus(self)    
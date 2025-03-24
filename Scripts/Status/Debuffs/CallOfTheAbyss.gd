class_name CallOfTheAbyss extends UnStackableStatus

func setup_Status(start_count : int, new_owner: Entities) -> Status:
    image_path = "res://icons/789_Lorc_RPG_icons/Icon.6_81.png"
    type = 1
    name = "Call of the Abyss"
    return super(start_count, new_owner)

func roundStart():
    decrementCount()

func decrementCount(times : int = 1):
    super(times)
    if count <= 0:
        owner.change_health(-50)
class_name CallOfTheAbyss extends UnStackableStatus

func setup_Status(start_count : int, new_owner: Entities) -> Status:
    status_attributes = load(RESOURCE_PATH + "Debuffs/call_of_the_abyss.tres")
    type = StatusType.DEBUFF
    return super(start_count, new_owner)

func roundStart():
    decrementCount()

func decrementCount(times : int = 1):
    super(times)
    if count <= 0:
        owner.change_health(-50)
        owner.removeStatus(self)
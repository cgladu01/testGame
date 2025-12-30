class_name Bud extends UnStackableStatus


func setup_Status(start_count : int, new_owner: Entities) -> Status:
    status_attributes = load(RESOURCE_PATH + "Buffs/bud.tres")
    return super(3, new_owner)

func roundStart():
    decrementCount(1)

func decrementCount(times: int = 1):
    count = count - times
    if count == 0:
        owner.removeStatus(self)
        owner.addStatus(Flower.new().setup_Status(1, owner), owner)

func brokenBlockEffect():
    owner.removeStatus(self)    
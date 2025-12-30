class_name Flower extends Status

func setup_Status(start_count : int, new_owner: Entities) -> Status:
    status_attributes = load(RESOURCE_PATH + "Buffs/flower.tres")
    return super(start_count, new_owner)


func attackMultEffect(incoming: int, attacker: Entities, target: Entities) -> int:
    incoming = floor(incoming + (incoming * count/10.0))
    return incoming

func blockMultEffect(block: int):
    return block + floor(block * count/10.0)
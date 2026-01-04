class_name Rot extends Status

func setup_Status(start_count : int, new_owner: Entities) -> Status:
	status_attributes = load(RESOURCE_PATH + "Debuffs/rot.tres")
	type = StatusType.DEBUFF
	return super(start_count, new_owner)

func roundEnd():
	count = count - 1
	if count == 0:
		owner.removeStatus(self)

func attackAddEffect(incoming: int, attacker: Entities, target: Entities) -> int:
	return incoming - count
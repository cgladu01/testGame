class_name Bleed extends Status

func setup_Status(start_count : int, new_owner: Entities) -> Status:
	status_attributes = load(RESOURCE_PATH + "Debuffs/bleed.tres")
	type = StatusType.DEBUFF
	return super(start_count, new_owner)

func unblockEffect(damage : int):
	owner.change_health(-count)

func roundEnd():
	count = count / 2
	if count == 0:
		owner.removeStatus(self)

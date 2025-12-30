class_name Silence extends Status

func setup_Status(start_count : int, new_owner: Entities) -> Status:
	status_attributes = load(RESOURCE_PATH + "Debuffs/silence.tres")
	type = StatusType.DEBUFF
	return super(start_count, new_owner)

func roundEnd():
	decrementCount()

func decrementCount(times: int = 1):
	super(times)
	if count <= 0:
		owner.removeStatus(self)
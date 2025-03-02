class_name Silence extends Status

func setup_Status(start_count : int, new_owner: Entities) -> Status:
	image_path = "res://icons/789_Lorc_RPG_icons/Icon.7_75.png"
	name = "Silence"
	return super(start_count, new_owner)

func roundStart():
	decrementCount()

func decrementCount(times: int = 1):
	super(times)
	if count <= 0:
		owner.removeStatus(self)
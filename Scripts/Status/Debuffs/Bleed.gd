class_name Bleed extends Status

func setup_Status(start_count : int, new_owner: Entities) -> Status:
	image_path = "res://icons/789_Lorc_RPG_icons/Icon.1_06.png"
	type = 1
	name = "Bleed"
	return super(start_count, new_owner)

func unblockEffect(damage : int):
	owner.change_health(-count)

func roundEnd():
	count = count / 2
	if count == 0:
		owner.removeStatus(self)

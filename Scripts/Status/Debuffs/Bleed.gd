class_name Bleed extends Status

func setup_Status(start_count : int, new_owner: Entities) -> Status:
	image_path = "res://icons/789_Lorc_RPG_icons/Icon.1_06.png"
	name = "Bleed"
	return super(start_count, new_owner)
class_name Howl extends EnemyActions
const  BASE_STRENGTH_GAIN = 1
const BASE_SHIELD_GAIN = 7

func setup(owner: Enemy):
	add_action_pair("res://icons/789_Lorc_RPG_icons/Icon.1_88.png", BASE_STRENGTH_GAIN)
	add_action_pair("res://icons/789_Lorc_RPG_icons/Icon.3_66.png", BASE_SHIELD_GAIN)
	name = "Howl"
	super(owner)


func execute():
	owner.gainBlock(7)
	var buff = Strength.new()
	buff.setup_Status(1, owner)
	owner.addStatus(buff, owner)
	

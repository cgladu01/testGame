class_name Howl extends "res://Scripts/Entities/Enemy/EnemyActions.gd"

func setup(owner: Enemy):
	imageIndicator.append("res://icons/789_Lorc_RPG_icons/Icon.1_88.png")
	imageIndicator.append("res://icons/789_Lorc_RPG_icons/Icon.3_66.png")
	name = "Howl"
	super(owner)


func execute():
	owner.gainBlock(7)
	var buff = Strength.new()
	buff.setup_Status(1)
	owner.addStatus(buff, owner)
	

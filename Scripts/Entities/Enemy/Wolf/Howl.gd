class_name Howl extends "res://Scripts/Entities/Enemy/EnemyActions.gd"


func execute():
	owner.block = 20
	var buff = Strength.new()
	buff.setup_Status(1)
	owner.addStatus(buff)
	

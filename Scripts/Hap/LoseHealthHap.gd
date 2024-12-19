class_name LoseHealthHap extends "res://Scripts/Hap/Hap.gd"


var entity : Entities = null
var amount : int = 0

func setup_LoseHealthHap(amount : int, entity : Entities):
	self.entity = entity
	self.amount = amount
	self.description = str(entity.name, " loses ", amount, " health.")
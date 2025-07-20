class_name LoseBlockHap extends "res://Scripts/Hap/hap.gd"

var entity : Entities = null
var amount : int = 0

func setup_LoseBlockHap(amount : int, entity : Entities):
	self.entity = entity
	self.amount = amount
	self.description = str(entity.name, " loses ", amount, " block.")

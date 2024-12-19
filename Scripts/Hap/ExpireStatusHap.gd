class_name ExpireStatusHap extends "res://Scripts/Hap/Hap.gd"

var entity : Entities = null
var status : Status = null

func setup_ExpireStatusHap(status : Status, entity : Entities):
	self.entity = entity
	self.status = status
	self.description = str(entity.name, " loses status ", status.name, ".")
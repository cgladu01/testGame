class_name MovementHap extends "res://Scripts/Hap/Hap.gd"


var entity : Entities = null
var origin : Vector2i = Vector2i(-1, -1)
var end : Vector2i = Vector2i(-1, -1)

func setup_MovementHap(origin: Vector2i, end: Vector2i, entity : Entities):
	self.entity = entity
	self.origin = origin
	self.end = end
	self.description = str(entity.name, " moves from ", origin, " to ", end, ".")

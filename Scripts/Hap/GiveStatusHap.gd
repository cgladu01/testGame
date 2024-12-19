class_name GiveStatusHap extends "res://Scripts/Hap/Hap.gd"

var recipient : Entities = null
var sender : Entities = null
var status : Status = null

func setup_GiveStatusHap(status : Status, recipient: Entities, sender: Entities):
	self.status = status
	self.recipient = recipient
	self.sender = sender
	self.description = str(recipient.name, " gave status: ", status.name, " with count ", status.count, " to ", sender.name, ".")
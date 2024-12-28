class_name AttackHap extends "res://Scripts/Hap/Hap.gd"

var recipient : Entities = null
var sender : Entities = null
var damage : int = -1

func setup_AttackHap(damage : int, recipient: Entities, sender: Entities):
	self.damage = damage
	self.recipient = recipient
	self.sender = sender
	self.description = str(sender.name, " attacks for ", damage, " damage to ", recipient.name)

class_name AttackHap extends Hap

var recipient : Entities = null
var sender : Entities = null
var damage : int = -1

func setup_AttackHap(damage : int, recipient: Entities, sender: Entities):
	self.damage = damage
	self.recipient = recipient
	self.sender = sender
	self.description = str(sender.name, " attacks for ", damage, " damage to ", recipient.name)

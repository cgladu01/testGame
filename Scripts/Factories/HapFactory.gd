class_name HapFactory extends Node

func createAttackHap(damage : int, recipient: Entities, sender: Entities):
	var newHap : AttackHap = AttackHap.new()
	newHap.setup_AttackHap(damage, recipient, sender)
	Global.log_container.gainHap(newHap)

func createExpireStatusHap(status : Status, entity : Entities):
	var newHap : ExpireStatusHap = ExpireStatusHap.new()
	newHap.setup_ExpireStatusHap(status, entity)
	Global.log_container.gainHap(newHap)

func createGiveStatusHap(status : Status, recipient: Entities, sender: Entities):
	var newHap : GiveStatusHap = GiveStatusHap.new()
	newHap.setup_GiveStatusHap(status, recipient, sender)
	Global.log_container.gainHap(newHap)

func createHap(text : String):
	var newHap : Hap = Hap.new()
	newHap.description = text
	Global.log_container.gainHap(newHap)

func createLoseBlockHap(amount : int, entity : Entities):
	var newHap : LoseBlockHap = LoseBlockHap.new()
	newHap.setup_LoseBlockHap(amount, entity)
	Global.log_container.gainHap(newHap)

func createLoseHealthHap(amount : int, entity : Entities):
	var newHap : LoseHealthHap = LoseHealthHap.new()
	newHap.setup_LoseHealthHap(amount, entity)
	Global.log_container.gainHap(newHap)

func createMovementHap(origin: Vector2i, end: Vector2i, entity : Entities):
	var newHap : MovementHap = MovementHap.new()
	newHap.setup_MovementHap(origin, end, entity)
	Global.log_container.gainHap(newHap)

func createStartOfRoundHap(round: int):
	var newHap : StartOfRoundHap = StartOfRoundHap.new()
	newHap.setup_StartOfRoundHap(round)
	Global.log_container.gainHap(newHap)

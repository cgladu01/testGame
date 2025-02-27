class_name Defend extends Action


func setup(owner: Character):
	name = "Defend"
	description = "Gain 5 block"
	type = 1
	super(owner)


func button_pressed():
	Global.actionSelection(self)

func execute():
	if canPlay():
		owner.gainBlock(5)
		super()
		owner.discardDeck.insertAtFront(self)

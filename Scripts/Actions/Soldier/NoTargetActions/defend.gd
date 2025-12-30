class_name Defend extends Action


func setup(owner: Character):
	actionAttributes = load("res://Resources/Actions/Soldier/NoTargetAction/defend.tres")
	cost = 1
	super(owner)


func button_pressed():
	Global.actionSelection(self)

func execute():
	if canPlay():
		owner.gainBlock(5)
		super()
		owner.discardDeck.insertAtFront(self)

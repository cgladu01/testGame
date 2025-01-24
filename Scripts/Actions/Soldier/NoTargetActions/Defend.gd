class_name Defend extends Action


func setup(owner: Entities):
	name = "Defend"
	super(owner)


func button_pressed():
	Global.actionSelection(self)

func execute():
	if canPlay():
		owner.gainBlock(5)
	super()

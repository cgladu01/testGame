class_name Defend extends Action


func setup(owner: Entities):
	name = "Defend"
	super(owner)


func button_pressed():
	Global.actionSelection(self)
	Global.selectionTile.clear()
	owner.gainBlock(5)
	super()

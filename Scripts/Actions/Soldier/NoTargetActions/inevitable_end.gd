class_name InevitableEnd extends Action

func setup(owner: Character):
	actionAttributes = load("res://Resources/Actions/Soldier/NoTargetAction/inevitable_end.tres")
	cost = 3
	super(owner)

func button_pressed():
	Global.actionSelection(self)

func execute():
	if canPlay():
		owner.addStatus(InevitableEndStatus.new().setup_Status(1, owner), owner)
		super()

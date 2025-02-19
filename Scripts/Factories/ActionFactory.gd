class_name ActionFactory


func createAction(name : String, owner : Entities) -> Action:

	var action : Action = null
	match name:
		"Move":
			action = Move.new()
			action.setup(owner)
		
		"Attack":
			action = Attack.new()
			action.setup(owner)
		"Bash":
			action = Bash.new()
			action.setup(owner)
		"Defend":
			action = Defend.new()
			action.setup(owner)
		"Bear Witness":
			action = BearWitness.new()
			action.setup(owner)
		_:
			action= Action.new()
			action.setup_placeholder(name, owner)

	return action

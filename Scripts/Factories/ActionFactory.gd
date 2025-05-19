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
		"Thorn Barrage":
			action = ThornBarrage.new()
			action.setup(owner)
		"Silent Protector":
			action = SilentProtector.new()
			action.setup(owner)
		"Splintering Shield":
			action = SplinteringShield.new()
			action.setup(owner)
		"Blossoming Blade":
			action = BlossomingBlade.new()
			action.setup(owner)
		_:
			action= Action.new()
			action.setup_placeholder(name, owner)

	return action


# Generates actions based on the owner gonna have
# Will need to make a proper resource file or something else (JSON?)
# of all actions to do this

var possibleActions = ["Thorn Barrage", "Bash"]
func createRandomAction(owner : Entities) -> Action:
	return createAction(possibleActions[Global.rng.rand_weighted(PackedFloat32Array([1, 1]))], owner)

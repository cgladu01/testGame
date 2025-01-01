class_name CombatDeck extends Deck

func setup(init_actions: Array[Action]):
	actions = init_actions.duplicate(true)
	actions.shuffle()
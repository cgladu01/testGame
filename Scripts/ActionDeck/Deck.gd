class_name Deck extends Node

var actions: Array[Action] = []

func setupDeck(actions : Array[Action]):
	self.actions = actions.duplicate()

func addAction(newAction : Action):
	actions.append(newAction)

func removeAction(number : int):
	actions.remove_at(number)

func generateCombatDeck() -> CombatDeck:
	var combadeck: CombatDeck = CombatDeck.new()
	combadeck.setup(actions)
	return combadeck

func insertAtPos(action: Action, pos: int):
	actions.insert(pos, action)

func insertAtFront(action: Action):
	actions.push_front(action)

func insertAtBack(action: Action):
	actions.push_back(action)

func insertRandomly(action: Action):
	actions.insert(Global.rng.randi_range(0, actions.size() - 1), action)

func draw(count: int) -> Array[Action]:
	var returner: Array[Action]
	for x in range(0, count):
		returner.append(actions.pop_front())
	return returner
		
func removeAtPos(pos: int):
	actions.remove_at(pos)

func addActions(newactions : Array[Action]):
	actions.append_array(newactions)

func empty() -> Array[Action]:
	var returner : Array[Action] = []
	while not actions.is_empty():
		returner.append(actions.pop_front())
	return returner

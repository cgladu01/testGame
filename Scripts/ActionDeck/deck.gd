class_name Deck
# Simulates a deck with Godot Arrays
var actions: Array[Action] = []
var attacks: int = 0
var skills: int = 0
var powers: int = 0
var curses: int = 0

func setupDeck(actions : Array[Action]):
	addActions(actions.duplicate())

func addAction(newAction : Action):
	match  newAction.type:
		Global.card_type.ATTACK:
			attacks += 1
		Global.card_type.SKILL:
			skills += 1
		Global.card_type.POWER:
			powers += 1
		Global.CURSE:
			curses += 1
	actions.append(newAction)

func removeAction(action : Action):
	var number: int = 0
	for x in actions:
		if x == action:
			break
		number += 1

	actions.remove_at(number)

func generateCombatDeck() -> CombatDeck:
	var combatdeck: CombatDeck = CombatDeck.new()
	combatdeck.setup(actions)
	return combatdeck

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

func intersect(compared_actions: Array[Action]) -> Array[Action]:
	var resulting_actions : Array[Action] = []
	for action in actions:
		if action in compared_actions:
			resulting_actions.append(action)
	
	return resulting_actions

func addActions(newactions : Array[Action]):
	for new_action in newactions:
		addAction(new_action)

func empty() -> Array[Action]:
	var returner : Array[Action] = []
	while not actions.is_empty():
		returner.append(actions.pop_front())
	return returner

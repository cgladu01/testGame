class_name CombatDeck extends Deck

var pitched_cards : int = 0

"""
Will have to come up with elegant way to display some cards have been inserted randomly
and thus could be in any part of the deck. Currently displays random cards first then pitched.
This is only really going to a problem when somebody pitches then a random card is shuffled in.
"""

var random_cards : Array[Action] = []

func setup(init_actions: Array[Action]):
	actions = init_actions.duplicate(true)
	actions.shuffle()

func insertAtBack(action: Action):
	super(action)
	pitched_cards += 1

func random_actions(standard_deck : Deck) -> Array[Action]:
	var returner : Array[Action] = []
	
	returner.append_array(standard_deck.intersect(self.actions.slice(0, actions.size() - pitched_cards)))

	for x in actions.slice(actions.size() - 1, actions.size() - pitched_cards):
		if x not in returner:
			returner.append(x)

	return returner


func non_random_actions() -> Array[Action]:
	var returner : Array[Action] = []
	for x in range(actions.size() - pitched_cards, actions.size()):
		returner.append(actions[x])
	
	return returner
		 
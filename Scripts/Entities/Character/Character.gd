class_name Character
extends Entities

# Character class
var energy : int = 3
var max_energy : int = 3
var deck: Deck = Deck.new()
var combatDeck : CombatDeck = null
var discardDeck : CombatDeck = null
var exhaustDeck : CombatDeck = null
var hand : CombatDeck = null
var round_start_draw : int = 5
var movement = Global.actionFactory.createAction("Move", self)
var moved = false
var pitched = false

func setup_character(init_name : String, starting_actions : Array[Action], start_health : int, start_location : Vector2i, start_node : CharacterNode, mini_portrait_path : String) -> void:
	name = init_name
	deck.setupDeck(starting_actions)
	miniPortaitPath = mini_portrait_path
	start_node.set_character(self)
	setup_entity(start_health, start_location, init_name, start_node)


func roundStart():
	super()
	moved = false
	pitched = false
	energy = max_energy
	handleDraw(round_start_draw)


# If you draw more cards then in deck, shiffle in discard after doing draw.
func handleDraw(drawCount: int):
	if combatDeck.actions.size() < drawCount:
		var amount : int = combatDeck.actions.size()
		hand.addActions(combatDeck.draw(amount))
		if discardDeck.actions.is_empty():
			return
		else: 
			combatDeck.shuffle_in(discardDeck.empty())
			handleDraw(drawCount - amount)
	else:
		hand.addActions(combatDeck.draw(drawCount))


func combatStart():
	combatDeck = deck.generateCombatDeck()
	discardDeck = CombatDeck.new()
	exhaustDeck = CombatDeck.new()
	hand = CombatDeck.new()

func roundEnd():
	discardDeck.addActions(hand.empty())

func clicked():
	if moved:
		pass
	else:
		movement.button_pressed()
		

func _init() -> void:
	pass

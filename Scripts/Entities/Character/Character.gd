class_name Character
extends Entities
var actions : Array[Action] = []
var energy : int = 3
var max_energy : int = 3
var deck: Deck = null
var combatDeck : CombatDeck = null
var discardDeck : CombatDeck = null
var exhaustDeck : CombatDeck = null


func get_actions() -> Array[Action]:
	return actions

func setup_character(init_name : String, starting_actions : Array[Action], start_health : int, start_location : Vector2i, start_node : CharacterNode, mini_portrait_path : String) -> void:
	name = init_name
	actions = starting_actions
	miniPortaitPath = mini_portrait_path
	start_node.set_character(self)
	setup_entity(start_health, start_location, init_name, start_node)

func roundStart():
	energy = max_energy

func _init() -> void:
	pass

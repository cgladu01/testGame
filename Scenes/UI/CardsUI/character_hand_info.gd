class_name  CharacterHandInfo extends Control

var character: Character
@onready var panelwindow = $"Window"
var card_container_scene = preload("res://Scenes/UI/CardsUI/CardContainer/card_container.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_character(new_character: Character):
	character = new_character
	panelwindow.set_entityDisplay(character)
	for action in character.hand.actions:
		var card_container = card_container_scene.instantiate()
		add_child(card_container)
		card_container.setAction(action, true)
	





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

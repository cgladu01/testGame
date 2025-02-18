extends Control
# Responsible for displaying actions.

@onready var grid_container: HBoxContainer = $HBoxContainer/Cards
@onready var label: Label = $HBoxContainer/Label
var card_container_scene = preload("res://Scenes/UI/CardsUI/CardContainer/card_container.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_action_update(CombatDeck.new(), 0, 0)
	Global.update_energy.connect(_update_energy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_execute():
	pass

func action_menu_clear(button_name: String):
	for child in grid_container.get_children():
		if child is Button:
			var button = child as Button
			if button.text == button_name:
				button.disabled = true

# Takes in actions and displays them on the grid 
# Called from Control Node
func on_action_update(actionsList: CombatDeck, energy: int, max_energy: int):
	clear_action_grid()

	for action in actionsList.actions:
		# Old Button System
		# var new_button = Button.new()
		# new_button.text = action.name
		# new_button.custom_minimum_size = Vector2i(20, 42)
		# new_button.disabled = action.used
		# new_button.pressed.connect(action.button_pressed())
		# action.button = new_button
		# grid_container.add_child(new_button)

		var card_container = card_container_scene.instantiate()
		grid_container.add_child(card_container)
		card_container.setAction(action)
	
	if actionsList.actions.size() != 0:
		label.text = str(energy) + "/" + str(max_energy)
	else:
		label.text = ""

func _update_energy(energy: int, max_energy: int):
	if grid_container.get_child_count() != 0:
		label.text = str(energy) + "/" + str(max_energy)
	
func clear_action_grid():
	for child in grid_container.get_children():
		grid_container.remove_child(child)
		child.queue_free()

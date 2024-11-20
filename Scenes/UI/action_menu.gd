extends Control
@onready var grid_container: GridContainer = $HBoxContainer/GridContainer
@onready var label: Label = $HBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_action_update([], 0, 0)
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

func on_action_update(actionsList: Array[Action], energy: int, max_energy: int):
	clear_action_grid()
	grid_container.columns = 1
	var element_count: int = 0
	for action in actionsList:
		element_count += 1
		if element_count % 2 == 0:
			grid_container.columns += 1
		var new_button = Button.new()
		new_button.text = action.name
		new_button.custom_minimum_size = Vector2i(20, 42)
		new_button.disabled = action.used
		new_button.pressed.connect(action.button_pressed())
		action.button = new_button
		grid_container.add_child(new_button)
	
	if actionsList.size() != 0:
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

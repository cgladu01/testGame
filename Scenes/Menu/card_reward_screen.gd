class_name CardRewardScreen extends VBoxContainer


var actions : Array[Action] = []
var card_container_scene = preload("res://Scenes/UI/CardsUI/CardContainer/card_container.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func displayActions(disp_actions: Array[Action]):
	actions = disp_actions
	var margin_size = (DisplayServer.screen_get_size().x / actions.size()) - Global.CARD_CONTAINER_SIZE
	for action in actions:
		var cardcontainer = card_container_scene.instantiate()
		var padding = MarginContainer.new()
		padding.add_theme_constant_override("margin_left", margin_size)
		add_child(padding)
		padding.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		add_child(cardcontainer)
		cardcontainer.setAction(action, true)
		cardcontainer.setBehavior(func (): Global.characters[0].deck.insertAtBack(action))
		cardcontainer.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_skip_button_pressed() -> void:
	queue_free()

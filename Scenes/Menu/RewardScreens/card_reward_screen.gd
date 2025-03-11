class_name CardRewardScreen extends VBoxContainer


var actions : Array[Action] = []
var card_container_scene = preload("res://Scenes/UI/CardsUI/CardContainer/card_container.tscn")
@onready var cardLayer = $MarginContainer/CardLayers

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func displayActions(disp_actions: Array[Action]):
	actions = disp_actions
	for action in actions:
		var cardcontainer = card_container_scene.instantiate()
		cardLayer.add_child(cardcontainer)
		cardcontainer.setAction(action, true)
		cardcontainer.setBehavior(func (): 
			Global.characters[0].deck.insertAtBack(action)
			Global.rewardTaken.emit()
			queue_free())

		cardcontainer.size_flags_horizontal = Control.SIZE_SHRINK_CENTER + Control.SIZE_EXPAND
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_skip_button_pressed() -> void:
	queue_free()

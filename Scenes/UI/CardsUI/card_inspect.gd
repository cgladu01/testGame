class_name CardInspect extends PanelContainer
@onready var energyCost: Label = $CardContainer/VBoxContainer/HBoxContainer/EnergyCost
@onready var cardName: Label = $CardContainer/VBoxContainer/HBoxContainer/CardName
@onready var cardImage: TextureRect = $CardContainer/VBoxContainer/CardImage
@onready var cardDescription: Label = $CardContainer/VBoxContainer/CardDescription

var action : Action = null

func setAction(action : Action):
	self.action = action 
	# self.cardImage = 
	self.cardName.text = action.name
	self.cardDescription.text = action.description

func _on_gui_input(event:InputEvent) -> void:
	if event is InputEventMouse and event.is_pressed():
		queue_free()

func _on_card_container_gui_input(event: InputEvent) -> void:
	pass # Replace with function body.

class_name CardContainer extends PanelContainer
@onready var energyCost: Label = $VBoxContainer/HBoxContainer/EnergyCost
@onready var cardName: Label = $VBoxContainer/HBoxContainer/CardName
@onready var cardImage: TextureRect = $VBoxContainer/CardImage
@onready var cardDescription: Label = $VBoxContainer/CardDescription

var action : Action = null

func setAction(action : Action):
	
	self.action = action 
	# self.cardImage = 
	self.cardName.text = action.name
	self.cardDescription.text = action.description
	action.container = self


func _on_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			action.button_pressed()

func onPlay():
	action.owner.hand.removeAction(action)
	queue_free()
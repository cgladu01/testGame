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

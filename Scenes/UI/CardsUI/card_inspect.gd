class_name CardInspect extends PanelContainer
@onready var energyCost: Label = $CardContainer/VBoxContainer/HBoxContainer/EnergyCost
@onready var cardName: Label = $CardContainer/VBoxContainer/HBoxContainer/CardName
@onready var cardImage: TextureRect = $CardContainer/VBoxContainer/CardImage
@onready var cardDescription: RichTextLabel = $CardContainer/VBoxContainer/CardDescription

var action : Action = null

func setAction(action : Action):
	self.action = action 
	# self.cardImage = 
	self.cardName.text = action.name
	self.cardDescription.text = action.description
	if action:
		var regex = RegEx.new()
		regex.compile("\\]([A-Za-z0-9\\s]*)\\[")
		for results in regex.search_all(action.description):
			await get_tree().create_timer(0).timeout
			Global.keywordHandler.generateToolTip(results.get_string(1), cardDescription)



func _on_gui_input(event:InputEvent) -> void:
	if event is InputEventMouse and event.is_pressed():
		self.cardDescription.text = action.description
		var regex = RegEx.new()
		regex.compile("\\]([A-Za-z0-9\\s]*)\\[")
		for results in regex.search_all(action.description):
			Global.keywordHandler.removeToolTip(results.get_string(1))
		queue_free()

func _on_card_container_gui_input(event: InputEvent) -> void:
	pass # Replace with function body.

class_name CardContainer extends PanelContainer
@onready var energyCost: Label = $VBoxContainer/HBoxContainer/EnergyCost
@onready var cardName: Label = $VBoxContainer/HBoxContainer/CardName
@onready var cardImage: TextureRect = $VBoxContainer/CardImage
@onready var cardDescription: Label = $VBoxContainer/CardDescription

var action : Action = null
var selectionNumber: Label = null
var isCardInpsection = false

func setAction(action : Action):
	
	self.action = action 
	# self.cardImage = 
	self.cardName.text = action.name
	self.cardDescription.text = action.description
	action.container = self


func _on_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Global.select_mode == null:
			action.button_pressed()
		elif event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			onSelect()
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and not isCardInpsection:
			print("Right Click")
			
func onSelect():
	Global.select_mode.selectedAction(action)

	if selectionNumber == null:
		selectionNumber = Label.new()
		get_tree().get_root().add_child(selectionNumber)
		selectionNumber.global_position = self.global_position + Vector2(self.size.x/2, -50)
		selectionNumber.text = str(Global.select_mode.getIndex(action))
		
		Global.select_mode.end.connect(func():  if is_instance_valid(selectionNumber): selectionNumber.queue_free())
		Global.select_mode.updateOrder.connect(func(): if is_instance_valid(selectionNumber): selectionNumber.text = str(Global.select_mode.getIndex(action)))

	elif Global.select_mode.getIndex(action) != 0:
		selectionNumber.text = str(Global.select_mode.getIndex(action))
	else:
		selectionNumber.queue_free()


func onPlay():
	action.owner.hand.removeAction(action)
	queue_free()

func onShuffle():
	action.owner.hand.removeAction(action)
	queue_free()

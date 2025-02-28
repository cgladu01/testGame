class_name CardContainer extends PanelContainer
@onready var energyCost: Label = $VBoxContainer/HBoxContainer/EnergyCost
@onready var cardName: Label = $VBoxContainer/HBoxContainer/CardName
@onready var cardImage: TextureRect = $VBoxContainer/CardImage
@onready var cardDescription: Label = $VBoxContainer/CardDescription

var action : Action = null
var selectionNumber: Label = null
var inspect_resource = preload("res://Scenes/UI/CardsUI/CardInspect.tscn")
var inspect_scene = null
var unplayable = false
var behavior : Callable = func () : return null
var behavior_set : bool = false

func setAction(action : Action, s_unplayable = false):
	
	self.action = action 
	# self.cardImage = 
	self.cardName.text = action.name
	self.cardDescription.text = action.description
	action.container = self
	unplayable = s_unplayable

# Activate card on left click and inspect card on right click
func _on_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Global.select_mode == null and not unplayable:
			if not behavior_set:
				action.button_pressed()
			else:
				behavior.call()
		elif event.pressed and event.button_index == MOUSE_BUTTON_LEFT and not unplayable:
			onSelect()
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if inspect_scene == null:
				inspect_scene = inspect_resource.instantiate()
				for child in get_tree().get_root().get_child(1).get_children():
					if child is CanvasLayer:
						child.add_child(inspect_scene)
						child.move_child(inspect_scene, -1)

				inspect_scene.setAction(action)

func setBehavoir(new_behavior: Callable):
	behavior_set = true
	behavior = new_behavior

# Handles the Select Mode interactions			
func onSelect():
	Global.select_mode.selectedAction(action)

	if selectionNumber == null:

		# Makes the number that exists above it when selected. Also provides lambda functions to update and delete them when they are not needed
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

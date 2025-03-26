class_name EventNode extends PanelContainer

var event : Event = null
var event_choices_preload = preload("res://Scenes/UI/Events/EventOption.tscn")
@onready var label : Label = $HBoxContainer/VBoxContainer/Label
@onready var eventDiscription : RichTextLabel = $HBoxContainer/VBoxContainer/EventDescription
@onready var vbox : VBoxContainer = $HBoxContainer/VBoxContainer

func _ready() -> void:
	if event:
		eventDiscription.text = event.description
		label.text = event.name
	
		for option in event.choices:
			var event_option = event_choices_preload.instantiate()
			event_option.eventOption = option
			vbox.add_child(event_option)
		

		

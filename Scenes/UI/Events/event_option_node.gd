class_name EventOptionNode extends PanelContainer

var event_option : EventOption
@onready var description = $RichTextLabel

func _ready() -> void:
	if event_option:
		description.append_text(event_option.text)


func _on_rich_text_label_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event_option:
				event_option.behavior.call()

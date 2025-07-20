extends PanelContainer

var end_turn_signal = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("MouseClick"):
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func recieve_signal(end_turn: Signal):
	end_turn_signal = end_turn

func _on_yes_button_pressed() -> void:
	end_turn_signal.emit()
	queue_free()

func _on_no_button_pressed() -> void:
	queue_free()

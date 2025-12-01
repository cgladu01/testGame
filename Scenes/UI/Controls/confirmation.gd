extends HBoxContainer
# Confirmation window that appears when clicking cards or enters a select mode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_deny_pressed() -> void:
	if Global.select_mode != null:
		Global.select_mode.onDecline()
	end()

func _on_confirm_pressed() -> void:
	if Global.select_mode != null:
		Global.select_mode.onConfirm()
	else:
		Global.currentAction.execute()

	end()

func end():
	Global.confirm_pressed.emit()
	Global.currentAction = null
	Global.selection = false
	Global.selectionTile.clear()
	Global.select_mode = null
	Global.unitsNode.clear_action_line()
	queue_free()

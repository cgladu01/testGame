class_name Topbar extends PanelContainer



func _on_map_pressed() -> void:
	$'../Control'._on_map_pressed.emit()

func _on_pause_pressed() -> void:
	$'../Control'._on_pause_pressed.emit()


func _on_button_pressed() -> void:
	if Global.currentRoom.completed:
		pass
	else:
		Global.fadeAwayToolTip("Current Room Not Completed")

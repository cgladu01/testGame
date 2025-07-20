class_name Topbar extends PanelContainer

var party_view_load = preload("res://Scenes/Menu/party_menu.tscn")
var party_view = null


func _on_map_pressed() -> void:
	$'../Control'._on_map_pressed.emit()

func _on_pause_pressed() -> void:
	$'../Control'._on_pause_pressed.emit()


func _on_button_pressed() -> void:
	if party_view:
		party_view.queue_free()
		return

	if Global.currentRoom.completed:
		party_view = party_view_load.instantiate()
		Global.canvas_layer.add_child(party_view)
	else:
		Global.fadeAwayToolTip("Current Room Not Completed")

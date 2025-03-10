class_name Topbar extends PanelContainer



func _on_map_pressed() -> void:
    $'../Control'._on_map_pressed.emit()

func _on_pause_pressed() -> void:
    $'../Control'._on_pause_pressed.emit()

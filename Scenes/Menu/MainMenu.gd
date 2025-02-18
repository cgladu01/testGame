extends PanelContainer

# Main menu
var mapOne = "res://Scenes/Maps/initial.tscn"
@onready var text_edit : LineEdit = $"GridContainer/HBoxContainer/LineEdit"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	Global.level_number = int(text_edit.text)
	get_tree().change_scene_to_file(mapOne)


func _on_quit_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

class_name SeeAllHandsNode extends VBoxContainer

var character_hand_info_load = preload("res://Scenes/UI/CardsUI/character_hand_info.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func displayAllHands():
	for character in Global.characters:
		var character_hand_info_scene = character_hand_info_load.instantiate()
		add_child(character_hand_info_scene)
		character_hand_info_scene.set_character(character)
		move_child(character_hand_info_scene, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_gui_input(event:InputEvent) -> void:
	if event is InputEventMouse and event.is_pressed():
		queue_free()

func _on_button_pressed() -> void:
	queue_free()

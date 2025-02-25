class_name SeeAllHandsNode extends VBoxContainer

var character_hand_info_load = preload("res://Scenes/UI/CardsUI/CharacterHandInfo.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func displayAllHands():
	for character in Global.characters:
		var character_hand_info_scene = character_hand_info_load.instantiate()
		add_child(character_hand_info_scene)
		character_hand_info_scene.set_character(character)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

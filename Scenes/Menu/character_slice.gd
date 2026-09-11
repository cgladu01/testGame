class_name CharacterSlice extends Control

var character: Character = null
@onready var mini_portrait : TextureRect = $HBoxContainer/VBoxContainer/MiniPortrait
@onready var char_name : RichTextLabel = $HBoxContainer/VBoxContainer/Name
@onready var health : RichTextLabel = $HBoxContainer/Health
@onready var equipment : HBoxContainer = $HBoxContainer/Equipment

func _ready() -> void:
	char_name.clear()
	char_name.add_text(self.character.name)
	for i in range(0, character.equipment.size()):
		equipment.get_child(i).setup(character.equipment.get(i))
	print(character.miniPortaitPath)
	mini_portrait.texture = load(character.miniPortaitPath)
	mini_portrait.size = Vector2i(70,70)

func setup(s_character: Character):
	self.character = s_character

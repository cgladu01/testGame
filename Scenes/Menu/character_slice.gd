class_name CharacterSlice extends Control

var character: Character = null
@onready var sprite : Sprite2D = $HBoxContainer/VBoxContainer/Sprite2D
@onready var char_name : RichTextLabel = $HBoxContainer/VBoxContainer/Name
@onready var health : RichTextLabel = $HBoxContainer/Health
@onready var equipment : HBoxContainer = $HBoxContainer/Equipment

func _ready() -> void:
	char_name.add_text(self.character.name)
	print(character.name)
	for i in range(0, character.equipment.size()):
		equipment.get_child(i).setup(character.equipment.get(i))

func setup(s_character: Character):
	self.character = s_character

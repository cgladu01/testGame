class_name CharacterSlice extends Control

var character: Character = null
@onready var sprite : Sprite2D = $HBoxContainer/VBoxContainer/Sprite2D
@onready var char_name : RichTextLabel = $HBoxContainer/VBoxContainer/Name
@onready var health : RichTextLabel = $HBoxContainer/Health

func _ready() -> void:
    pass
    

func setup(character: Character):
    self.character = character


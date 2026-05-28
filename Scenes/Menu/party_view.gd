class_name PartyView extends Control


var character_slice_load = preload("res://Scenes/Menu/character_slice.tscn")
var characters : Array[Character]
@onready var vbox = $VBoxContainer


func _ready() -> void:
    for character in characters:
        var character_slice = character_slice_load.instantiate()
        character_slice.setup(character)
        vbox.add_child(character_slice)

func setup(characters : Array[Character]):
    characters = characters

    
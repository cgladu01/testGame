class_name PickCharacter extends HBoxContainer


var character_load = preload("res://Scenes/Menu/character_select.tscn")
var behavior : Callable = func (): print("No behavior set")
var character = null
var rewardItem: RewardItem = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    Global.rewardTaken.connect(_on_rewardTaken)
    for character in Global.characters:
        var character_screen = character_load.instantiate()
        character_screen.set_Character(character)
        add_child(character_screen)

func _on_rewardTaken():
    queue_free()

func set_behavior(s_behavior: Callable):    
    behavior = s_behavior
    for child in get_children():
        child.set_behavior(behavior)
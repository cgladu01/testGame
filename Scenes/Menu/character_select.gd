class_name CharacterSelect extends PanelContainer

@onready var characterNameLabel = $Hbox/CharacterName

var character = null
var behavior : Callable = func(): print(character.name)

func _ready() -> void:
	characterNameLabel.text = character.name

func setup(s_behavior : Callable, set_Character : Character):
	set_Character(set_Character)
	set_behavior(behavior)

func set_Character(new_character: Character):
	character = new_character

func set_behavior(s_behavior: Callable):
	behavior = s_behavior
	
func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("MouseClick"):
		Global.selected_character = character
		behavior.call()
		get_parent().rewardItem.behavior = behavior
		get_parent().queue_free()

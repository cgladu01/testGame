class_name CharacterSelect extends PanelContainer

@onready var characterNameLabel = $Hbox/CharacterName
@onready var health_text = $Hbox/VBoxContainer/Health
@onready var health_bar = $Hbox/VBoxContainer/HealthBar

var character = null
var behavior : Callable = func(): print(character.name)

func _ready() -> void:
	if character:
		characterNameLabel.text = character.name
		_update_health()

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

func _update_health():
	health_text.text = str(character.get_health()) + "/" + str(character.tot_health)
	health_bar.value = (character.get_health() as float) / (character.tot_health) * 100
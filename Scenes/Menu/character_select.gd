class_name CharacterSelect extends PanelContainer

@onready var characterNameLabel = $Hbox/CharacterName
@onready var health_text = $Hbox/VBoxContainer/Health
@onready var health_bar = $Hbox/VBoxContainer/HealthBar
@onready var cardStaticsHolder = $Hbox/CardStatisticsHolder

var character = null
var behavior : Callable = func(): print(character.name)

func _ready() -> void:
	if character:
		characterNameLabel.text = character.name
		_update_health()
		fill_card_statistics()

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

func fill_card_statistics():
	for i in range(cardStaticsHolder.get_child_count()):
		var box : VBoxContainer = cardStaticsHolder.get_child(i)
		var text : RichTextLabel = box.get_child(0)
		var panel : Panel = box.get_child(1)
		var count : int = 0
		var style_block = StyleBoxFlat.new()
		match i:
			Global.card_type.ATTACK:
				text.append_text(str(character.deck.attacks))
				count = character.deck.attacks
				style_block.bg_color = Color.RED
				style_block.bg_color.a = 1
			Global.card_type.SKILL:
				text.append_text(str(character.deck.skills))
				count = character.deck.skills
				style_block.bg_color = Color.BLUE
				style_block.bg_color.a = 1
			Global.card_type.POWER:
				text.append_text(str(character.deck.powers))
				count = character.deck.powers
				style_block.bg_color = Color.GREEN
				style_block.bg_color.a = 1
			Global.card_type.CURSE:
				text.append_text(str(character.deck.curses))
				count = character.deck.curses
		

		panel.add_theme_stylebox_override("panel", style_block)
		panel.custom_minimum_size = Vector2(panel.size.x, (count * 100) / (character.deck.actions.size()) * 5)

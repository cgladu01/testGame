class_name Action

var actionAttributes : ActionAttributes = ActionAttributes.new()

var owner : Character
var used : bool = false
var container : CardContainer = null
var upgraded : int = 0
var cost : int = 1

signal executed

func setup(owner : Character):
	self.owner = owner

func setup_placeholder(init_name: String, owner : Entities, character_name: String = ""):
	if character_name == "":
		character_name = "Soldier"
	actionAttributes = load("res://Assets/Actions/" + character_name + "/" + init_name + ".tres")
	setup(owner)

func hover_action(current_tile: Vector2i):
	pass

func button_pressed():
	print("Do nothing")

func canPlay():
	if actionAttributes.type == Global.card_type.SKILL and owner.hasStatus("Silence") != null:
		return false

	if owner is Character:
		var character = owner as Character
		return character.energy - actionAttributes.cost >= 0

func _get(property: StringName) -> Variant:
	if property in actionAttributes:
		return actionAttributes.get(property)
	else:
		return get(property)

func execute():
	Global.selectionTile.clear()
	if canPlay():
		if owner is Character:
			var character = owner as Character
			character.energy = character.energy - actionAttributes.cost

			Global.update_energy.emit(character.energy, character.max_energy)		
		if container:
			container.onPlay()

func duplicate(deep: bool = false) -> Action:
	var new_action: Action = Global.actionFactory.createAction(actionAttributes.name, owner)
	upgraded = self.upgraded
	return new_action

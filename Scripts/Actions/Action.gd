class_name Action

var name : String = "Unknown"
var cost : int = 1
var description : String = "Undefined"
var image_path : String = ""
var owner : Character
var used : bool = false

var container : CardContainer = null
var type : int = 0
var upgraded : int = 0

signal executed

func setup(owner : Character):
	self.owner = owner

func setup_placeholder(init_name: String, owner : Entities):
	name = init_name
	setup(owner)

func hover_action(current_tile: Vector2i):
	pass

func button_pressed():
	print("Do nothing")

func canPlay():
	if type == Global.card_type.SKILL and owner.hasStatus("Silence") != null:
		return false

	if owner is Character:
		var character = owner as Character
		return character.energy - cost >= 0

func execute():
	Global.selectionTile.clear()
	if canPlay():
		if owner is Character:
			var character = owner as Character
			character.energy = character.energy - cost

			Global.update_energy.emit(character.energy, character.max_energy)		
		if container:
			container.onPlay()

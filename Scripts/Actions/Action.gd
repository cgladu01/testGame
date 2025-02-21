class_name Action

var name : String = "Unknown"
var owner : Entities
var used : bool = false
var cost : int = 1
var description : String = "Undefined"
var image_path : String = ""
var container : CardContainer = null
var type : int = 0
var upgraded : int = 0

signal executed

func setup(owner : Entities):
	self.owner = owner

func setup_placeholder(init_name: String, owner : Entities):
	name = init_name
	setup(owner)

func hover_action(current_tile: Vector2i):
	pass

func button_pressed():
	print("Do nothing")

func canPlay():
	if owner is Character:
		var character = owner as Character
		return character.energy >= cost

func execute():
	Global.selectionTile.clear()
	if canPlay():
		if owner is Character:
			var character = owner as Character
			character.energy = character.energy - cost

			Global.update_energy.emit(character.energy, character.max_energy)		
		if container:
			container.onPlay()